if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/admin/shared/sub_menu/_configuration',
    name: 'add_analytics_to_admin_sidebar',
    insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
    partial: 'spree/admin/shared/analytics_sidebar_menu',
    original: '2bb6a12bc74827ab85597c64a2c2f0be4cde1263'
  )
end
