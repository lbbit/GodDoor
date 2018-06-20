package net.cloud.base.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import net.cloud.base.common.JsonResult;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import net.cloud.base.entity.User;
import net.cloud.base.service.support.IBaseService;

/**
 * <p>
 * 用户服务类
 * </p>
 *
 * @author Jerry
 *
 */
public interface IUserService extends IBaseService<User, Integer> {

    /**
     * 根据用户名查找用户
     *
     * @param username
     * @return
     */
    User findByUserName(String username);

    /**
     * 对外接口：注册用户，返回提示
     * @param jsonData
     * @return
     */
    JsonResult save(String jsonData);

    /**
     * 增加或者修改用户
     *
     * @param user
     */
    void saveOrUpdate(User user);

    /**
     * 给用户分配角色
     *
     * @param id      用户ID
     * @param roleIds 角色Ids
     */
    void grant(Integer id, String[] roleIds);

    /**
     * 根据关键字获取分页
     *
     * @param searchText
     * @param pageRequest
     * @return
     */
    Page<User> findAllByLike(String searchText, PageRequest pageRequest);

    /**
     * 修改用户密码
     *
     * @param user
     * @param oldPassword
     * @param password1
     * @param password2
     */
    void updatePwd(User user, String oldPassword, String password1, String password2);

}
