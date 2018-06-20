package net.cloud.base.service.impl;

import net.cloud.base.dao.IDeviceDao;
import net.cloud.base.dao.support.IBaseDao;
import net.cloud.base.entity.Device;
import net.cloud.base.service.IDeviceService;
import net.cloud.base.service.support.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by Jerry on 2018/5/3 0003.
 */
@Service
public class DeviceServiceImpl extends BaseServiceImpl<Device, Integer> implements IDeviceService {

    @Autowired
    private IDeviceDao deviceDao;

    @Override
    public IBaseDao<Device, Integer> getBaseDao() {
        return this.deviceDao;
    }
}
