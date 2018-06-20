package net.cloud.base.dao;

import net.cloud.base.dao.support.IBaseDao;
import net.cloud.base.entity.Resource;
import org.springframework.stereotype.Repository;

/**
 * Created by Jerry on 2018/5/3 0003.
 */
@Repository
public interface IRelation extends IBaseDao<Resource,Integer> {
}
