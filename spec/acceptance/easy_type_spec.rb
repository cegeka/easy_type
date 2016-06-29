require 'spec_helper_acceptance'

describe 'easy_type' do

  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS

        require 'spec_helper'
        require 'easy_type/file_includer'
        
        describe EasyType::FileIncluder do
          include EasyType::FileIncluder
        
          context "a file does exist" do
        
            before do
              include_file "easy_type/include_check.rb"
            end
        
            it "evaluates the ruby code in the file" do
              expect(file_is_included).to be true
            end
          end
        
          context "a file does not exist" do
        
            it "raises an ArgumentError" do
              expect{ include_file "easy_type/nonexisting_file.rb"}.to raise_error(ArgumentError)
            end
          end
        
        end
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
