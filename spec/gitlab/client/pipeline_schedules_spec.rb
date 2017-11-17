require 'spec_helper'

describe Gitlab::Client do
  describe '.pipeline_schedules' do
    before do
      stub_get('/projects/5/pipeline_schedules', 'pipeline_schedules')
      @pipeline_schedules = Gitlab.pipeline_schedules(5)
    end
    it "should get the correct resource" do
      expect(a_get("/projects/5/pipeline_schedules")).to have_been_made
    end
    it "should return a paginated response of pipeline schedules" do
      expect(@pipeline_schedules).to be_a Gitlab::PaginatedResponse
    end
  end
  describe '.pipeline_schedule' do
    before do
      stub_get('/projects/5/pipeline_schedules/13', 'pipeline_schedule')
      @pipeline_schedule = Gitlab.pipeline_schedule(5, 13)
    end
    it "should get the correct resource" do
      expect(a_get("/projects/5/pipeline_schedules/13")).to have_been_made
    end
    it "should return information about a pipeline schedule" do
      expect(@pipeline_schedule).to be_a Gitlab::ObjectifiedHash
      expect(@pipeline_schedule.id).to eq(13)
    end
  end
  describe '.create_pipeline_schedule' do
    before do
      stub_post('/projects/5/pipeline_schedules', 'pipeline_schedule')
      @pipeline_schedule = Gitlab.create_pipeline_schedule(5, options: {description: 'Test Schedule Pipeline', ref: 'master', cron: '* * * * *', cron_timezone: 'Asia/Tokyo', active: true})
    end
    it "should get the correct resource" do
      expect(a_post("/projects/5/pipeline_schedules")).to have_been_made
          # with(body: {description: 'Test Schedule Pipeline', ref: 'master', cron: '* * * * *', cron_timezone: 'Asia/Tokyo', active: true})).to have_been_made
    end
  end
  describe '.update_pipeline_schedule' do
    before do
    end
  end
  describe '.own_pipeline_schedule' do
    before do
    end
  end
  describe '.delete_pipeline_schedule' do
    before do
    end
  end
  describe '.create_pipeline_schedule_variable' do
    before do
    end
  end
  describe '.edit_pipeline_schedule_variable' do
    before do
    end
  end
  describe '.delete_pipeline_schedule_variable' do
    before do
    end
  end
end