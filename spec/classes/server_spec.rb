require 'spec_helper'

describe 'ssh::server' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        it ' should update sshd config' do
          is_expected.to contain_augeas('/etc/ssh/sshd_config').with(
            :context => '/files/etc/ssh/sshd_config',
            :changes => [
              'set ChallengeResponseAuthentication no',
              'set PasswordAuthentication yes',
              'set X11Forwarding yes',
              'set PrintMotd no',
            ]
          ) 
        end
      end

      context 'change ChallengeResponseAuthentication' do
        let(:params) {{ :challenge_response_authentication => true }}
        it ' should update sshd config' do
          is_expected.to contain_augeas('/etc/ssh/sshd_config').with(
            :context => '/files/etc/ssh/sshd_config',
            :changes => [
              'set ChallengeResponseAuthentication yes',
              'set PasswordAuthentication yes',
              'set X11Forwarding yes',
              'set PrintMotd no',
            ]
          ) 
        end
      end

      context 'change password_authentication' do
        let(:params) {{ :password_authentication => false }}
        it ' should update sshd config' do
          is_expected.to contain_augeas('/etc/ssh/sshd_config').with(
            :context => '/files/etc/ssh/sshd_config',
            :changes => [
              'set ChallengeResponseAuthentication no',
              'set PasswordAuthentication no',
              'set X11Forwarding yes',
              'set PrintMotd no',
            ]
          ) 
        end
      end

      context 'change x11_forwading' do
        let(:params) {{ :x11_forwading => false }}
        it ' should update sshd config' do
          is_expected.to contain_augeas('/etc/ssh/sshd_config').with(
            :context => '/files/etc/ssh/sshd_config',
            :changes => [
              'set ChallengeResponseAuthentication no',
              'set PasswordAuthentication yes',
              'set X11Forwarding no',
              'set PrintMotd no',
            ]
          ) 
        end
      end

      context 'change print_mod' do
        let(:params) {{ :print_mod => true }}
        it ' should update sshd config' do
          is_expected.to contain_augeas('/etc/ssh/sshd_config').with(
            :context => '/files/etc/ssh/sshd_config',
            :changes => [
              'set ChallengeResponseAuthentication no',
              'set PasswordAuthentication yes',
              'set X11Forwarding yes',
              'set PrintMotd yes',
            ]
          ) 
        end
      end

      context 'pass incorrect challenge_response_authentication' do
        let(:params) {{ :challenge_response_authentication => 'foo' }}
        it do
          expect {
            subject.call
          }.to raise_error(Puppet::Error)
        end
      end

      context 'pass incorrect password_authentication' do
        let(:params) {{ :password_authentication => 'foo' }}
        it do
          expect {
            subject.call
          }.to raise_error(Puppet::Error)
        end
      end

      context 'pass incorrect x11_forwading' do
        let(:params) {{ :x11_forwading => 'foo' }}
        it do
          expect {
            subject.call
          }.to raise_error(Puppet::Error)
        end
      end

      context 'pass incorrect print_mod' do
        let(:params) {{ :print_mod => 'foo' }}
        it do
          expect {
            subject.call
          }.to raise_error(Puppet::Error)
        end
      end

      case facts[:operatingsystem]
      when 'Ubuntu'
        it { is_expected.to contain_package('openssh-server').with_ensure(
          'present') }
      end

    end
  end
end
