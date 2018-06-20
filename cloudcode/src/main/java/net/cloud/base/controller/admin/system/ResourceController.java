package net.cloud.base.controller.admin.system;

import java.util.List;

import net.cloud.base.controller.BaseController;
import net.cloud.base.entity.Resource;
import net.cloud.base.service.IResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.cloud.base.common.JsonResult;
import net.cloud.base.vo.ZtreeView;

@Controller
@RequestMapping("/admin/resource")
public class ResourceController extends BaseController {
    @Autowired
    private IResourceService resourceService;

    @RequestMapping("/tree/{resourceId}")
    @ResponseBody
    public List<ZtreeView> tree(@PathVariable Integer resourceId) {
        List<ZtreeView> list = resourceService.tree(resourceId);
        return list;
    }

    @RequestMapping("/index")
    public String index(ModelMap map) {
        Page<Resource> page = resourceService.findAll(getPageRequest());
        map.put("pageInfo", page);
        return "admin/resource/index";
    }

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String add(ModelMap map) {
        List<Resource> list = resourceService.findAll();
        map.put("list", list);
        return "admin/resource/form";
    }


    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable Integer id, ModelMap map) {
        Resource resource = resourceService.find(id);
        map.put("resource", resource);

        List<Resource> list = resourceService.findAll();
        map.put("list", list);
        return "admin/resource/form";
    }

    @RequestMapping(value = {"/edit"}, method = RequestMethod.POST)
    @ResponseBody
    public JsonResult edit(Resource resource, Integer parentId, ModelMap map) {
        try {
            if (parentId != null) {
                Resource parent = new Resource();
                parent.setId(parentId);
                resource.setParent(parent);
            }
            resourceService.saveOrUpdate(resource);
        } catch (Exception e) {
            return JsonResult.failure(e.getMessage());
        }
        return JsonResult.success();
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JsonResult delete(@PathVariable Integer id, ModelMap map) {
        try {
            resourceService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
            return JsonResult.failure(e.getMessage());
        }
        return JsonResult.success();
    }
}
