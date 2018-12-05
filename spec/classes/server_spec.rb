# frozen_string_literal: true

require 'spec_helper'

describe 'ssh::server' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      case facts[:operatingsystem]
      when 'FreeBSD'
        let(:group) { 'wheel' }
      else
        let(:group) { 'root' }
      end

      context 'with defaults' do
        it 'update sshd config' do
          is_expected.to contain_file('/etc/ssh/sshd_config').with(
            ensure: 'file',
            mode: '0644',
            user: 'root',
            group: group,
          ).with_content(
            %r{^RootAuthentication prohibit-password$},
          ).with_content(
            %r{^ChallengeResponseAuthentication no$},
          ).with_content(
            %r{^PasswordAuthentication yes$},
          ).with_content(
            %r{^X11Forwarding yes$},
          ).with_content(
            %r{^PrintMotd no$},
          )
        end
      end

      context 'change ChallengeResponseAuthentication' do
        let(:params) { { challenge_response_authentication: true } }

        it 'update sshd config' do
          is_expected.to contain_file('/etc/ssh/sshd_config').with(
            ensure: 'file',
            mode: '0644',
            user: 'root',
            group: group,
          ).with_content(
            %r{^RootAuthentication prohibit-password$},
          ).with_content(
            %r{^ChallengeResponseAuthentication yes$},
          ).with_content(
            %r{^PasswordAuthentication yes$},
          ).with_content(
            %r{^X11Forwarding yes$},
          ).with_content(
            %r{^PrintMotd no$},
          )
        end
      end

      context 'change password_authentication' do
        let(:params) { { password_authentication: false } }

        it 'update sshd config' do
          is_expected.to contain_file('/etc/ssh/sshd_config').with(
            ensure: 'file',
            mode: '0644',
            user: 'root',
            group: group,
          ).with_content(
            %r{^RootAuthentication prohibit-password$},
          ).with_content(
            %r{^ChallengeResponseAuthentication no$},
          ).with_content(
            %r{^PasswordAuthentication no$},
          ).with_content(
            %r{^X11Forwarding yes$},
          ).with_content(
            %r{^PrintMotd no$},
          )
        end
      end

      context 'change x11_forwading' do
        let(:params) { { x11_forwading: false } }

        it 'update sshd config' do
          is_expected.to contain_file('/etc/ssh/sshd_config').with(
            ensure: 'file',
            mode: '0644',
            user: 'root',
            group: group,
          ).with_content(
            %r{^RootAuthentication prohibit-password$},
          ).with_content(
            %r{^ChallengeResponseAuthentication no$},
          ).with_content(
            %r{^PasswordAuthentication yes$},
          ).with_content(
            %r{^X11Forwarding no$},
          ).with_content(
            %r{^PrintMotd no$},
          )
        end
      end

      context 'change print_motd' do
        let(:params) { { print_mod: true } }

        it 'update sshd config' do
          is_expected.to contain_file('/etc/ssh/sshd_config').with(
            ensure: 'file',
            mode: '0644',
            user: 'root',
            group: group,
          ).with_content(
            %r{^RootAuthentication prohibit-password$},
          ).with_content(
            %r{^ChallengeResponseAuthentication no$},
          ).with_content(
            %r{^PasswordAuthentication yes$},
          ).with_content(
            %r{^X11Forwarding yes$},
          ).with_content(
            %r{^PrintMotd yes$},
          )
        end
      end

      context 'change root authentication' do
        let(:params) { { root_authentication: false } }

        it 'update sshd config' do
          is_expected.to contain_file('/etc/ssh/sshd_config').with(
            ensure: 'file',
            mode: '0644',
            user: 'root',
            group: group,
          ).with_content(
            %r{^RootAuthentication no$},
          ).with_content(
            %r{^ChallengeResponseAuthentication no$},
          ).with_content(
            %r{^PasswordAuthentication yes$},
          ).with_content(
            %r{^X11Forwarding yes$},
          ).with_content(
            %r{^PrintMotd no$},
          )
        end
      end

      context 'pass incorrect challenge_response_authentication' do
        let(:params) { { challenge_response_authentication: 'foo' } }

        it { expect { subject.call }.to raise_error(Puppet::Error) }
      end

      context 'pass incorrect password_authentication' do
        let(:params) { { password_authentication: 'foo' } }

        it { expect { subject.call }.to raise_error(Puppet::Error) }
      end

      context 'pass incorrect x11_forwading' do
        let(:params) { { x11_forwading: 'foo' } }

        it { expect { subject.call }.to raise_error(Puppet::Error) }
      end

      context 'pass incorrect print_mod' do
        let(:params) { { print_mod: 'foo' } }

        it { expect { subject.call }.to raise_error(Puppet::Error) }
      end

      context 'pass incorrect root_authentication' do
        let(:params) { { root_authentication: 'foo' } }
        
        it { expect { subject.call }.to raise_error(Puppet::Error) }
      end

      case facts[:operatingsystem]
      when 'Ubuntu'
        it do
          is_expected.to contain_package('openssh-server').with_ensure(
            'present'
          )
        end
      end
    end
  end
end
