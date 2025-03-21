# Spree Starter

This is a starter kit for [Spree Commerce](https://spreecommerce.org) - the open-source e-commerce platform for Rails. It is a great starting point for any Rails developer to quickly build an e-commerce application.

This starter uses:

* Spree Commerce 5 which includes Admin Dashboard, API and Storefront - everything you need to start developing your new eCommerce application/store/marketeplace
* Stripe for payment processing, thanks to [Spree Stripe gem](https://github.com/spree/spree_stripe)
* [Devise](https://github.com/heartcombo/devise) for authentication
* [Solid Queue](https://github.com/rails/solid_queue) with Mission Control UI (access only to Spree admins) for background jobs
* [Solid Cache](https://github.com/rails/solid_cache) for excellent caching and performance
* PostgreSQL as a database

You don't need to install additional tools or libraries to start developing with Spree Starter. Everything is already set up for you.

If you like what you see, consider giving this repo a GitHub star :star:

Thank you for supporting Spree open-source :heart:

## Local Installation

Please follow [Spree Quickstart guide](https://spreecommerce.org/docs/developer/getting-started/quickstart) to setup your Spree application using the Spree starter.

## Deployment

Please follow [Deployment guide](https://spreecommerce.org/docs/developer/deployment/render) to quickly deploy your production-ready Spree application.

## Troubleshooting

### libvips error

If you encounter an error like the following:

```bash
LoadError: Could not open library 'vips.so.42'
```

Please check that libvips is installed with `vips -v`, and if it is not installed, follow [installation instructions here](https://www.libvips.org/install.html).
# teletri
