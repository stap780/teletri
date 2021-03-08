Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_related_products_admin_tab',
  insert_bottom: '[data-hook="admin_product_tabs"]',
  partial: 'spree/admin/products/related_products',
  original: '8db78f52302b2ec3da57a7cfe1d8e0a1159725ed'
)
