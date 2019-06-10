module AsyncRequest
  class JobsController < ActionController::Base
    def show
      job = Job.find_by(uid: params[:id])
      return head :not_found unless job.present?
      job.finished? ? render_finished_job(job) : render_pending(job)
    end

    private

    def render_pending(job)
      render json: { status: job.status }, status: :accepted
    end

    def render_finished_job(job)
      render json: JSON.parse(job.response), status: job.status_code
    end
  end
end
