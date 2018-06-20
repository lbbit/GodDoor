package net.cloud.base.service;

import net.cloud.base.entity.Resource;
import net.cloud.base.service.support.IBaseService;
import net.cloud.base.vo.ZtreeView;
import org.springframework.context.annotation.Bean;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 资源服务类
 * </p>
 *
 * @author Jerry
 *
 */
@Component
public interface IResourceService extends IBaseService<Resource, Integer> {

    /**
     * 获取角色的权限树
     *
     * @param roleId
     * @return
     */
    List<ZtreeView> tree(int roleId);

    /**
     * 修改或者新增资源
     *
     * @param resource
     */
    void saveOrUpdate(Resource resource);

    /**
     * 关键字分页
     *
     * @param searchText
     * @param pageRequest
     * @return
     */
    Page<Resource> findAllByLike(String searchText, PageRequest pageRequest);

}
