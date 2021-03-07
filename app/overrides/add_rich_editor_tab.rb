Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'add_rich_editor_tab',
  insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
  text:  <<-HTML
                  <%= configurations_sidebar_menu_item Spree.t('rich_editor'), edit_admin_editor_settings_path if can? :admin, Spree::EditorSetting %>
                 HTML
)
