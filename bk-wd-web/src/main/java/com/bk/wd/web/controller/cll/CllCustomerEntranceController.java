package com.bk.wd.web.controller.cll;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bk.cll.model.CllCeFrom;
import com.bk.cll.service.CllCeFromService;
import com.bk.cll.service.CllCustomerService;
import com.bk.wd.web.utils.MatrixToImageWriter;
import com.bk.common.utils.EntityUtils;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;

@Controller
@RequestMapping(value = "/cll/customerEntrance")
public class CllCustomerEntranceController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CllCustomerEntranceController.class);

	@Autowired
	private CllCeFromService cefromService;
	
	@Autowired
	private CllCustomerService cllCustomerService;

	@Value("${static.resources.url}")
	private String static_resources_url;
	
	@Value("${app.wap.download.url}")
	private String app_wap_download_url;

	@RequestMapping(value = { "/list" })
	public String fromList(Model model, HttpServletRequest request) {

		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("from_back_url", referer);

		SysUser currentUser = UserUtils.getUser();
		List<CllCeFrom> froms = cefromService.selectByCompanyId(currentUser.getCompanyId());
		List<Map<String, Object>> list = EntityUtils.convertToListMap(froms, "id", "fromA", "fromB", "createDate");
		for (Map<String, Object> map : list) {
			String fromA = map.get("fromA").toString();
			Integer count = cllCustomerService.countByFromA(fromA);
			map.put("count", count);
		}

		model.addAttribute("list", list);
		return "modules/cll/customerEntrance/list";
	}

	@RequestMapping(value = { "/DRCode" })
	public void fromQRCode(String id, HttpServletRequest request, HttpServletResponse response) {
		if (StringUtils.isBlank(id)) {
			return;
		}

		CllCeFrom from = cefromService.selectByPrimaryKey(id);
		if (null == from) {
			return;
		}

		if (StringUtils.isBlank(from.getFromA())) {
			return;
		}

		String url = static_resources_url + app_wap_download_url + "/?fromA="+ from.getFromA();

		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/octet-stream");

		String fileName = from.getFromA() + ".png";
		try {
			fileName = new String(fileName.getBytes(), "ISO-8859-1");
		} catch (UnsupportedEncodingException e1) {
			LOGGER.error(e1.getMessage(), e1);
			fileName = "DRCode.png";
		}

		response.addHeader("Content-Disposition", "attachment;filename=" + fileName);

		try (ServletOutputStream outputStream = response.getOutputStream();) {

			Hashtable<EncodeHintType, Object> hints = new Hashtable<>();
			hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
			BitMatrix bitMatrix = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, 520, 520, hints);
			MatrixToImageWriter.writeToStream(bitMatrix, "png", outputStream);

		} catch (IOException | WriterException e) {
			LOGGER.error(e.getMessage(), e);
		}
	}

	@RequestMapping(value = { "/form" }, method = { RequestMethod.GET })
	public String editFrom(Model model) {

		SysUser currentUser = UserUtils.getUser();
		CllCeFrom from = new CllCeFrom();
		from.setCompanyId(currentUser.getCompanyId());

		model.addAttribute("from", from);
		return "modules/cll/customerEntrance/editForm";
	}

	@RequestMapping(value = { "/form" }, method = { RequestMethod.POST })
	public String saveFrom(CllCeFrom model) {
		SysUser currentUser = UserUtils.getUser();

		String fromA = model.getFromA();
		if (StringUtils.isBlank(fromA)) {
			return "modules/cll/customerEntrance/editForm";
		}

		String companyId = model.getCompanyId();
		if (StringUtils.isBlank(companyId)) {
			companyId = currentUser.getCompanyId();
		}

		CllCeFrom oldFrom = cefromService.selectByCompanyIdAndFromA(companyId, fromA);
		if (null != oldFrom) {
			return "modules/cll/customerEntrance/editForm";
		}

		model.setId(UidUtil.uuid());
		model.setCompanyId(companyId);
		model.setCreateBy(currentUser.getId());
		model.setCreateDate(new Date());
		model.setUpdateBy(currentUser.getId());
		model.setUpdateDate(new Date());

		cefromService.insertSelective(model);

		return "modules/cll/customerEntrance/editForm";
	}
}
