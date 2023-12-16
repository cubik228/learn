module ErrorHandling
  extend ActiveSupport::Concern

  include do
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    private

    def render_404(_exception)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end
end
