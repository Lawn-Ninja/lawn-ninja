class JobsController < ApplicationController
  def jobs_near_me
    p current_user
    if current_user && current_user.provider
      @jobs = Job.jobs_near_me(current_user.zip_code) 
      render json: {jobs: @jobs}
      p "*" * 20
      p @jobs
      p "*" * 20
    else
      render json: {jobs: []}
      p "*" * 20
      p "nope"
      p "*" * 20
    end
  end

  def my_jobs
    @jobs = {
      "requested_jobs" => [],
      "scheduled_jobs" => [],
      "in_progress_jobs" => [],
      "completed_jobs" => []
    }
    status_key = {
      "posted" => "requested_jobs",
      "claimed" => "scheduled_jobs",
      "started" => "in_progress_jobs",
      "completed" => "completed_jobs"
    }
    current_user.jobs.each do |job|
      @jobs[status_key[job.status]] << job
    end
    jobs_as_provider = Job.where(provider_id: current_user.id)
    jobs_as_provider.each do |job|
      @jobs[status_key[job.status]] << job
    end
    # @jobs = current_user.jobs + Job.where(provider_id: current_user.id)
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
