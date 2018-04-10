package com.bk.wd.web.controller.xcx;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.common.entity.JsonResult;
import com.bk.common.utils.JGMessageUtils;
import com.bk.common.utils.StringUtils;
import com.bk.common.utils.UidUtil;
import com.bk.sys.model.SysUser;
import com.bk.sys.security.utils.UserUtils;
import com.bk.wd.model.WdCeCustomer;
import com.bk.wd.model.WdCeCustomerTrack;
import com.bk.wd.model.WdCeProductWithBLOBs;
import com.bk.wd.model.WdMessage;
import com.bk.wd.model.WdMessageReceiver;
import com.bk.wd.service.WdCeCustomerService;
import com.bk.wd.service.WdCeCustomerTrackService;
import com.bk.wd.service.WdCeProductService;
import com.bk.wd.service.WdMessageReceiverService;
import com.bk.wd.service.WdMessageService;
import com.bk.wd.util.BusinessConsts;
import com.bk.wd.util.BusinessConsts.TrueOrFalseAsString;
import com.bk.wd.web.base.BaseController;

@Controller
@RequestMapping(value = "/customer4c/server")
public class CustomerServerController extends BaseController {

	@Autowired
	private WdCeCustomerService ceCustomerService;
	@Autowired
	private WdCeCustomerTrackService ceCustomerTrackService;
	@Autowired
	private WdCeProductService ceProductService;
	@Autowired
	private WdMessageService wdMessageService;
	@Autowired
	private WdMessageReceiverService wdMessageReceiverService;
	@Autowired
	private JGMessageUtils jgMessageUtils;

	@RequiresPermissions("wd:4customer:view")
	@RequestMapping(value = { "/list" })
	public String list(Model model, WdCeCustomer ceCustomer, String target) {
		SysUser currentUser = UserUtils.getUser();
		ceCustomer.setBelongCompanyId(currentUser.getCompanyId());
		if (StringUtils.isBlank(ceCustomer.getStatus()) || ceCustomer.getStatus().equals("0")) {
			if (target.equals("assign")) {
				ceCustomer.setStatus("待分配");
			}
			if (target.equals("result")) {
				ceCustomer.setStatus("待处理,无效客户,已接收");
			}
		}
		if (null == ceCustomer.getCeProductId() || ceCustomer.getCeProductId().equals("0")) {
			ceCustomer.setCeProductId("");
		}

		List<WdCeCustomer> customers = ceCustomerService.selectByConditions(ceCustomer);
		for (WdCeCustomer wdCeCustomer : customers) {
			WdCeCustomerTrack ceCustomerTrack = ceCustomerTrackService
					.selectLastestOwnerByCustomerId(wdCeCustomer.getId());
			if (null != ceCustomerTrack) {
				wdCeCustomer.setOwnerId(ceCustomerTrack.getOwnerId());
				wdCeCustomer.setOwnerName(ceCustomerTrack.getOwnerName());
			}
		}

		List<WdCeProductWithBLOBs> products = ceProductService.selectEnabledByCompanyId(currentUser.getCompanyId());

		if (StringUtils.isBlank(ceCustomer.getCeProductId())) {
			ceCustomer.setCeProductId("0");
		}
		if (ceCustomer.getStatus().equals("待处理,无效客户,已接收")) {
			ceCustomer.setStatus("0");
		}

		model.addAttribute("searchParms", ceCustomer);
		model.addAttribute("customers", customers);
		model.addAttribute("products", products);

		model.addAttribute("target", target);

		return "modules/xcx/customerList";
	}

	@RequiresPermissions("wd:4customer:assign")
	@RequestMapping(value = { "/assign" })
	@ResponseBody
	public JsonResult assign(String userId, String ceCustomerIds) {
		SysUser user = UserUtils.get(userId);
		SysUser currentUser = UserUtils.getUser();
		for (String customerId : ceCustomerIds.split(",")) {
			WdCeCustomer ceCustomer = ceCustomerService.selectByPrimaryKey(customerId);
			ceCustomer.setStatus("待处理");
			ceCustomer.setUpdateBy(currentUser.getId());
			ceCustomer.setUpdateDate(new Date());
			ceCustomerService.updateByPrimaryKeySelective(ceCustomer);

			WdCeCustomerTrack track = new WdCeCustomerTrack();
			track.setId(UidUtil.uuid());
			track.setCeCustomerId(customerId);
			track.setOwnerId(user.getId());
			track.setOwnerName(user.getName());
			track.setStatus("待处理");
			track.setDisable(TrueOrFalseAsString.False);
			track.setDelFlag(false);
			track.setCreateBy(currentUser.getId());
			track.setCreateDate(new Date());
			track.setUpdateBy(currentUser.getId());
			track.setUpdateDate(new Date());
			ceCustomerTrackService.insertSelective(track);

			WdMessage message = new WdMessage();
			message.setId(UidUtil.uuid());
			message.setCategory("获客");
			message.setTitle(ceCustomer.getName());
			message.setSubtitle(ceCustomer.getTelphone());
			message.setContent("有一个新的客户任务");
			message.setMessageDate(new Date());
			message.setRelationId(ceCustomer.getId());
			message.setReadFlag(BusinessConsts.TrueOrFalseAsString.False);
			message.setDelFlag(false);
			message.setCreateBy(currentUser.getId());
			message.setCreateDate(new Date());
			message.setUpdateBy(currentUser.getId());
			message.setUpdateDate(new Date());

			WdMessageReceiver receiver = new WdMessageReceiver();
			receiver.setId(UidUtil.uuid());
			receiver.setMessageId(message.getId());
			receiver.setMessageDate(new Date());
			receiver.setReceiverId(user.getId());

			wdMessageService.insertSelective(message);
			wdMessageReceiverService.insertSelective(receiver);

			Map<String, String> extraInfo = new HashMap<>();
			extraInfo.put("category", "获客");
			extraInfo.put("relationId", message.getRelationId());

			String[] alias = new String[] { user.getId() };
			jgMessageUtils.sendMessageByAlias(alias, message.getTitle(), message.getContent(), extraInfo);
		}

		return new JsonResult();
	}

	@RequiresPermissions("wd:4customer:view")
	@RequestMapping(value = { "/track" })
	public String track(Model model, String customerId) {
		List<WdCeCustomerTrack> customerTracks = ceCustomerTrackService.selectByCeCustomerAndStatus(customerId, "无效客户");
		model.addAttribute("customerTracks", customerTracks);
		return "modules/xcx/customerTrackList";
	}
}
