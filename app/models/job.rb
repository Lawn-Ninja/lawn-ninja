class Job < ApplicationRecord
  belongs_to :user
  validates :requested_time, presence: true

  def self.jobs_near_me(provider_zip)
    jobs = []
    radius_miles = 5

    zip_codes = HTTP.get("https://www.zipcodeapi.com/rest/#{ENV['API_KEY']}/radius.json/#{provider_zip}/#{radius_miles}/mile?minimal").body.to_s.delete('{\"zip_codes\":[').delete(']}').split(',')

    zip_codes.each do |zc|
      users = User.where("zip_code = '#{zc}'")
      users.each do |user|
        user.jobs.each do |job|
          if job.status == "posted"
            jobs << job
          end
        end
      end
    end
    jobs
  end
end
