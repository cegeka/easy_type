require 'spec_helper_acceptance'

describe 'easy_type' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS

        require 'easy_type'

        $test = unsafe_munge('100M')
        puts "TEST input was 100M, test output is $test"
 
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    # describe port(22) do
    #   it { is_expected.to be_listening }
    # end

    # describe service('sshd') do
    #   it { is_expected.to be_enabled }
    #   it { is_expected.to be_running }
    # end
  end

end
