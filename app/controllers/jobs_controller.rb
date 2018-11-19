class JobsController < ApplicationController
  def index
    if current_user && current_user.provider
      jobs = Job.where(status: "posted")
      provider_zip = current_user.zip_code
      radius_miles = 5
      zip_codes = HTTP.get("https://www.zipcodeapi.com/rest/#{ENV['API_KEY']}/radius.json/#{provider_zip}/#{radius_miles}/miles").body.readpartial
      p zip_codes
      
      render json: {jobs: @jobs}
    else
      render json: {message: "Sorry, it looks like you aren't signed up to be a service provider."}
    end
  end

  def my_jobs
    @jobs = current_user.jobs + Job.where(provider_id: current_user.id)
    render json: {jobs: @jobs}
  end

  def new
    render 'new.html.erb'
  end

  def create
    @job = Job.new(job_params)
    @job.status = "posted"
    @job.user_id = current_user.id
    if @job.save
      render json: {job: @job}
    else
      render json: {errors: @job.errors.full_messages}, status: :unprocessible_entity
    end

  end

  def update
    @job = Job.find(params[:id])

    if @job.update_attributes(job_params)
      render json: {job: @job}
    else
      render json: {errors: @job.errors.full_messages}, status: :unprocessible_entity
    end
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

    def job_params
      params.require(:job).permit(:requested_time, :start_time, :end_time, :provider_id, :status)
    end
end
