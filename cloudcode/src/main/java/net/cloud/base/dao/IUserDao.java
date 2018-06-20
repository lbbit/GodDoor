package net.cloud.base.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import net.cloud.base.dao.support.IBaseDao;
import net.cloud.base.entity.User;

@Repository
public interface IUserDao extends IBaseDao<User, Integer> {

    User findByUserName(String username);

    Page<User> findAllByNickNameContaining(String searchText, Pageable pageable);

}
