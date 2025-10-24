class ApplicationController < ActionController::Base
  # Allow all browsers to access the application
  # allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
