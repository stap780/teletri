Deface::Override.new(
  virtual_path: 'spree/admin/shared/_content_header',
  name: 'add_my_products_admin_button',
  insert_before: '[data-hook="toolbar"]',
  partial: 'spree/admin/shared/ketago_products_button',
  original: '5223ee83d75c0c7db455d3b621d7b2600e32bb6e'
)
