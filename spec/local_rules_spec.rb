require File.expand_path('../spec_helper', __FILE__)

module Danger
  describe Danger::DangerLocalRules do
    let(:dangerfile) { testing_dangerfile }
    let(:plugin) { dangerfile.local_rules }
    let(:pr_diff) { dummy_pr_diff }
    let(:load_data) do
      {
        "failure" => {"legacy"=>"No!", "typo"=>"type"}, 
        "warning" => {"TODO"=>"You should check"}
      }
    end

    it 'should be a plugin' do
      expect(Danger::DangerLocalRules.new(nil)).to be_a Danger::Plugin
    end

    describe '#check' do
      let(:github_plugin)  { Danger::DangerfileGitHubPlugin }

      before do
        allow(YAML).to receive(:load_file).with('.danger_local_rules.yml').and_return(load_data)
        allow_any_instance_of(github_plugin).to receive(:pr_diff).and_return(pr_diff)
      end

      context 'passed' do
        it do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to eq(0)
        end
      end

      context 'diff which included string to warn' do
        let(:pr_diff) { dummy_warning_pr_diff }

        it 'should have a warning comment' do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to eq(0)
          expect(dangerfile.status_report[:warnings].length).to eq(1)
        end
      end

      context 'diff which included 2 strings to fail' do
        let(:pr_diff) { dummy_failure_pr_diff }

        it 'should have 2 failure comments' do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to eq(2)
          expect(dangerfile.status_report[:warnings].length).to eq(0)
        end
      end
    end
  end
end
