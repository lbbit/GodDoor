package net.cloud.base.config.shiro.freemarker;

/**
 * <p>Equivalent to {@link org.apache.shiro.web.tags.HasPermissionTag}</p>
 *
 *  0.1
 */
public class HasPermissionTag extends PermissionTag {
    protected boolean showTagBody(String p) {
        return isPermitted(p);
    }
}
