<#include "/admin/layout/layout.ftl">
<#import "/admin/layout/macro.ftl" as macro>
<#assign css>
<style>
</style>
</#assign>
<#assign js>
<script>

</script>
</#assign>
<@layout title="设备管理" active="user">
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        设备列表
        <small>查看当前注册设备</small>
    </h1>
    <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-cog"></i> 系统</a></li>
        <li><a href="#"><i class="fa fa-list-ul"></i> 设备管理</a></li>
        <li class="active"><i class="fa fa-table"></i> 设备列表</li>
    </ol>
</section>

<!-- Main content -->
<section class="content">
    <!-- Default box -->
    <div class="box box-primary">
        <div class="box-header">
       <#-- <@shiro.hasPermission name="system:user:add">
            <a class="btn btn-sm btn-success" href="${ctx!}/admin/user/add">注册新用户</a>
        </@shiro.hasPermission>-->
        </div>
        <div class="box-body">
            <table class="table table-striped">
                <tr>
                    <th>DeviceID</th>
                    <th>设备名</th>
                    <th>端口号</th>
                    <th>状态</th>
                </tr>
                <#list pageInfo.content as devInfo>
                <tr>
                    <td>${devInfo.id}</td>
                    <td>${devInfo.name}</td>
                    <td>${devInfo.port}</td>
                    <td>
                        <#if devInfo.status == 1>
                            <span class="label label-info">ON</span>
                        <#elseif devInfo.status == 0>
                            <span class="label label-danger">OFF</span>
                        <#else >
                            <span class="label label-warning">UnKnow</span>
                        </#if>
                    </td>
                    <td>${userInfo.createTime}</td>
                    <td>
                    <@shiro.hasPermission name="system:user:edit">
                        <a class="btn btn-sm btn-primary" href="${ctx!}/admin/user/edit/${userInfo.id}">编辑</a>
                    </@shiro.hasPermission>
                  <#--  <@shiro.hasPermission name="system:user:grant">
                        <a class="btn btn-sm btn-warning" href="${ctx!}/admin/user/grant/${userInfo.id}">分配角色</a>
                    </@shiro.hasPermission>-->
                    <@shiro.hasPermission name="system:user:deleteBatch">
                        <button class="btn btn-sm btn-danger" onclick="del(${userInfo.id})">删除</button>
                    </@shiro.hasPermission>
                    </td>
                </tr>
                </#list>
            </table>
        </div>
        <!-- /.box-body -->
        <div class="box-footer clearfix">
            <@macro.page pageInfo=pageInfo url="${ctx!}/admin/dev/index?" />
        </div>
    </div>
    <!-- /.box -->

</section>
<!-- /.content -->
</@layout>