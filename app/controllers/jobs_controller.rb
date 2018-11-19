class JobsController < ApplicationController
  def index
    if current_user && current_user.provider
      @jobs = []
      provider_zip = current_user.zip_code
      radius_miles = 5

      zip_codes = HTTP.get("https://www.zipcodeapi.com/rest/#{ENV['API_KEY']}/radius.json/#{provider_zip}/#{radius_miles}/mile?minimal").body.to_s.delete('{\"zip_codes\":[').delete(']}').split(',')
      # zip_codes = ["91803", "91899", "91802", "91804", "91841", "91896", "91801", "91776", "91778", "91030", "91031", "90042", "91775", "90050", "91189", "91118", "91108", "91184", "91115", "91125", "91126", "90041", "91106", "91105", "91123", "91124", "91129", "91102", "91182", "91188", "91116", "91117", "91101", "91110", "91131", "91191", "91121", "91107", "91226", "91109", "91114", "91206", "91104", "91103", "91199", "91003", "91001", "91012"]

      zip_codes.each do |zc|
        users = User.where("zip_code = '#{zc}'")
        users.each do |user|
          user.jobs.each do |job|
            if job.status == "posted"
              @jobs << job
            end
          end
        end
      end
      
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
