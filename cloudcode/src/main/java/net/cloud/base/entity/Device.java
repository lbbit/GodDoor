package net.cloud.base.entity;

import net.cloud.base.entity.support.BaseEntity;

import javax.persistence.*;

@Entity
@Table(name = "tb_device")
public class Device extends BaseEntity{
    private static final long serialVersionUID = 1L;

    /**
     * 设备id
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private Integer id;

    /**
     * 设备名
     */
    private String name;

    /**
     * 端口
     */
    private Integer port;

    /**
     * 状态,1是在线，0是离线
     */
    private Integer status;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPort() {
        return port;
    }

    public void setPort(Integer port) {
        this.port = port;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
