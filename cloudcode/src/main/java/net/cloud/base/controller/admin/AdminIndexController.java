package net.cloud.base.controller.admin;

import net.cloud.base.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminIndexController extends BaseController {
    @RequestMapping(value = {"/admin/", "/admin/index"})
    public String index() {

        return "admin/index";
    }
}
