Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_product',
  name: 'add_product_relation_admin_sub_menu_tab',
  insert_bottom: '[data-hook="admin_product_sub_tabs"]',
  text: '<%= tab :relation_types, label: plural_resource_name(Spree::RelationType) %>',
  original: 'fc4d1f6cdf01d2cd76eb35e3d72b3339e94978b9'
)
