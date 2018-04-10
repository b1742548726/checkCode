package com.bk.wd.web.controller.xcx;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.bk.common.entity.JsonResult;
import com.bk.common.service.DfsService;
import com.bk.common.utils.EntityUtils;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdCeFrom;
import com.bk.wd.model.WdCeProductWithBLOBs;
import com.bk.wd.model.WdCustomerType;
import com.bk.wd.service.WdCeCustomerService;
import com.bk.wd.service.WdCeFromService;
import com.bk.wd.service.WdCeProductService;
import com.bk.wd.util.BusinessConsts.TrueOrFalseAsString;
import com.bk.wd.web.base.BaseController;
import com.bk.wd.web.utils.MatrixToImageWriter;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;

@Controller
@RequestMapping(value = "/customer4c")
public class CustomerEntranceController extends BaseController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CustomerEntranceController.class);

	@Autowired
	private WdCeProductService ceProductService;

	@Autowired
	private WdCeCustomerService ceCustomerService;

	@Autowired
	private DfsService dfsService;

	@Autowired
	private WdCeFromService cefromService;

	@Value("${app.api.url}")
	private String app_api_url;

	@Value("${wxstatic.resources.url}")
	private String wsstatic_resources_url;

	@RequestMapping(value = { "/from/list" })
	public String fromList(Model model, HttpServletRequest request) {

		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("from_back_url", referer);

		SysUser currentUser = UserUtils.getUser();
		List<WdCeFrom> froms = cefromService.selectByCompanyId(currentUser.getCompanyId());
		List<Map<String, Object>> list = EntityUtils.convertToListMap(froms, "id", "fromA", "fromB", "createDate");
		for (Map<String, Object> map : list) {
			String fromA = map.get("fromA").toString();
			Integer count = ceCustomerService.countByFromA(currentUser.getCompanyId(), fromA);
			map.put("count", count);
		}

		model.addAttribute("list", list);

		return "modules/xcx/fromList";
	}

	@RequestMapping(value = { "/from/DRCode" })
	public void fromQRCode(String id, HttpServletRequest request, HttpServletResponse response) {
		if (StringUtils.isBlank(id)) {
			return;
		}

		WdCeFrom from = cefromService.selectByPrimaryKey(id);
		if (null == from) {
			return;
		}

		if (StringUtils.isBlank(from.getFromA())) {
			return;
		}

		String url = wsstatic_resources_url + "wap_wd/html/index.html?site=" + URLEncoder.encode(app_api_url)
				+ "&companyId=" + from.getCompanyId() + "&fromA=" + from.getFromA();

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
		} finally {

		}
	}

	@RequestMapping(value = { "/from/form" }, method = { RequestMethod.GET })
	public String editFrom(Model model) {

		SysUser currentUser = UserUtils.getUser();
		WdCeFrom from = new WdCeFrom();
		from.setCompanyId(currentUser.getCompanyId());

		model.addAttribute("from", from);
		return "modules/xcx/fromForm";
	}

	@RequestMapping(value = { "/from/form" }, method = { RequestMethod.POST })
	public String saveFrom(WdCeFrom model) {
		SysUser currentUser = UserUtils.getUser();

		String fromA = model.getFromA();
		if (StringUtils.isBlank(fromA)) {
			return "modules/xcx/fromForm";
		}

		String companyId = model.getCompanyId();
		if (StringUtils.isBlank(companyId)) {
			companyId = currentUser.getCompanyId();
		}

		WdCeFrom oldFrom = cefromService.selectByCompanyIdAndFromA(companyId, fromA);
		if (null != oldFrom) {
			return "modules/xcx/fromForm";
		}

		model.setId(UidUtil.uuid());
		model.setCompanyId(companyId);
		model.setCreateBy(currentUser.getId());
		model.setCreateDate(new Date());
		model.setUpdateBy(currentUser.getId());
		model.setUpdateDate(new Date());

		cefromService.insertSelective(model);

		return "modules/xcx/fromForm";
	}

	@RequestMapping(value = { "/product/list" })
	public String listProduct(Model model) {
		SysUser currentUser = UserUtils.getUser();

		List<WdCeProductWithBLOBs> list = ceProductService.selectByCompanyId(currentUser.getCompanyId());
		model.addAttribute("products", list);

		return "modules/xcx/productList";
	}

	@RequestMapping(value = { "/product" }, method = { RequestMethod.DELETE })
	@ResponseBody
	public JsonResult deleteProduct(String id) {
		SysUser currentUser = UserUtils.getUser();

		WdCeProductWithBLOBs product = ceProductService.selectByPrimaryKey(id);
		product.setEnable(TrueOrFalseAsString.False);
		product.setDelFlag(true);
		product.setUpdateBy(currentUser.getId());
		product.setUpdateDate(new Date());

		ceProductService.updateByPrimaryKeySelective(product);

		return new JsonResult();
	}

	@RequestMapping(value = { "/product" }, method = { RequestMethod.PUT })
	@ResponseBody
	public JsonResult enableProduct(String id, String enable) {
		SysUser currentUser = UserUtils.getUser();

		WdCeProductWithBLOBs product = ceProductService.selectByPrimaryKey(id);
		product.setEnable(enable);
		product.setUpdateBy(currentUser.getId());
		product.setUpdateDate(new Date());

		ceProductService.updateByPrimaryKeySelective(product);

		return new JsonResult();
	}

	@RequestMapping(value = { "/product/form" }, method = { RequestMethod.GET })
	public String editProduct(Model model, String id) {

		WdCeProductWithBLOBs product = ceProductService.selectByPrimaryKey(id);
		if (null == product) {
			product = new WdCeProductWithBLOBs();
			product.setBelongCompanyId(UserUtils.getUser().getCompanyId());
		}

		model.addAttribute("product", product);

		return "modules/xcx/productForm";
	}

	@RequestMapping(value = { "/product/form" }, method = { RequestMethod.POST })
	public String saveProduct(@RequestParam(value = "logoImg", required = false) CommonsMultipartFile logoImg,
			@RequestParam(value = "backgroundImg", required = false) CommonsMultipartFile backgroundImg,
			WdCeProductWithBLOBs product, HttpServletRequest request) {

		try {
			if (null != backgroundImg && !backgroundImg.isEmpty() && backgroundImg.getSize() > 0) {
				product.setBackgroundUrl(
						dfsService.uploadFile(backgroundImg.getBytes(), backgroundImg.getOriginalFilename()));
			}

			if (null != logoImg && !logoImg.isEmpty() && logoImg.getSize() > 0) {
				product.setLogoUrl(dfsService.uploadFile(logoImg.getBytes(), logoImg.getOriginalFilename()));
			}
		} catch (IOException e) {
			LOGGER.error("照片上传失败");
		}

		if (StringUtils.isBlank(product.getId())) {
			product.setId(UidUtil.uuid());
			product.setBelongCompanyId(UserUtils.getUser().getCompanyId());
			product.setSort(999);
			product.setCreateBy(UserUtils.getUser().getId());
			product.setCreateDate(new Date());
			product.setUpdateBy(UserUtils.getUser().getId());
			product.setUpdateDate(new Date());

			product.setDelFlag(false);

			ceProductService.insertSelective(product);

		} else {

			product.setUpdateBy(UserUtils.getUser().getId());
			product.setUpdateDate(new Date());

			product.setDelFlag(false);

			ceProductService.updateByPrimaryKeySelective(product);
		}

		return "modules/xcx/productList";
	}

	@RequestMapping(value = { "/product/sorts" })
	@ResponseBody
	public JsonResult sorts(String ids) {
		if (StringUtils.isNoneEmpty(ids)) {
			String[] idArray = ids.split(",");
			for (int i = 0; i < idArray.length; i++) {
				if (StringUtils.isNoneEmpty(idArray[i])) {
					WdCeProductWithBLOBs product = ceProductService.selectByPrimaryKey(idArray[i]);
					product.setSort(i);
					product.setUpdateBy(UserUtils.getUser().getId());
					product.setUpdateDate(new Date());
					ceProductService.updateByPrimaryKeySelective(product);
				}
			}
		}
		return new JsonResult();
	}

	@RequestMapping(value = { "/product/uploadImg" }, method = { RequestMethod.POST })
	@ResponseBody
	public JsonResult uploadImg(@RequestParam MultipartFile imgFile, HttpServletRequest request, String id,
			String imgType) {

		if (imgFile.getSize() == 0) {
			return new JsonResult(false, "图片读取失败");
		}

		String filePath = "";
		String fileName = imgFile.getOriginalFilename();
		String fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length()).toLowerCase();

		if (!(fileType.equals(".jpeg") || fileType.equals(".jpg") || fileType.equals(".bmp")
				|| fileType.equals(".png"))) {
			return new JsonResult(false, "目前只支持.jpg，.jpeg，.png，.bmp类型");
		}

		try {
			BufferedImage sourceImg = ImageIO.read(imgFile.getInputStream());
			System.out.println(sourceImg.getWidth());
			System.out.println(sourceImg.getHeight());

			if ("bg".equals(imgType) && (sourceImg.getWidth() != 1095 || sourceImg.getHeight() != 420)) {
				return new JsonResult(false, "图片尺寸只能是1095*420");
			}

		} catch (IOException e1) {
			e1.printStackTrace();

			return new JsonResult(false, "图片读取失败");
		}

		try {
			filePath = dfsService.uploadFile(imgFile.getBytes(), UidUtil.uuid() + imgFile.getOriginalFilename());
		} catch (IOException e) {
			LOGGER.error(e.getMessage(), e);
			return new JsonResult(false, "图片上传失败");
		}

		WdCeProductWithBLOBs product = ceProductService.selectByPrimaryKey(id);
		if (null == product || StringUtils.isBlank(product.getId())) {
			product = new WdCeProductWithBLOBs();
			if ("logo".equals(imgType)) {
				product.setLogoUrl(filePath);
			} else if ("bg".equals(imgType)) {
				product.setBackgroundUrl(filePath);
			}
			product.setId(UidUtil.uuid());
			product.setBelongCompanyId(UserUtils.getUser().getCompanyId());
			product.setCreateBy(UserUtils.getUser().getId());
			product.setCreateDate(new Date());
			product.setUpdateBy(UserUtils.getUser().getId());
			product.setUpdateDate(new Date());

			product.setDelFlag(true);

			ceProductService.insertSelective(product);
		} else {

			if ("logo".equals(imgType)) {
				product.setLogoUrl(filePath);
			} else if ("bg".equals(imgType)) {
				product.setBackgroundUrl(filePath);
			}
			product.setUpdateBy(UserUtils.getUser().getId());
			product.setUpdateDate(new Date());

			ceProductService.updateByPrimaryKeySelective(product);
		}

		return new JsonResult(true, product.getId());
	}
}
