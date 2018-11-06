class JobsController < ApplicationController
  def index
    @jobs = Job.all
    render json: {jobs: @jobs}
  end

  def my_jobs
    @jobs = current_user.jobs + Job.where(provider_id: current_user.id)
    render json: {jobs: @jobs}
  end

  def new
    render 'new.html.erb'
  end

  def create
    @job = Job.new(
      requested_time: params[:requested_time],
      user_id: current_user.id,
      status: "posted"
      )
    @job.save

    render json: {job: @job}
  end

  def update
    @job = Job.find(params[:id])

    @job.update(
      requested_time: params[:requested_time] || @job.requested_time,
      start_time: params[:start_time] || @job.start_time,
      end_time: params[:end_time] || @job.end_time,
      provider_id: params[:provider_id] || @job.provider_id,
      status: params[:status] || @job.status
      )

    render json: {job: @job}
    
  end

  def show
    @job = Job.find(params[:id])

    render json: {job: @job}
  end

  private
    def jobs_payload
      [
        {
          date: Time.now,
          time: Time.now,
          user:
            {
              first_name: "Bob",
              zip_code: 10000
            }
        },
        {
          date: Time.now,
          time: Time.now,
          user:
            {
              first_name: "Abby",
              zip_code: 20000
            }
        },
        {
          date: Time.now,
          time: Time.now,
          user:
            {
              first_name: "Susie",
              zip_code: 30000
            }
        }
      ]
    end
end
