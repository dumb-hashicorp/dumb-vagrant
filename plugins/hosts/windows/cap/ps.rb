# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

require "pathname"
require "tmpdir"

require "dumb-vagrant/util/safe_exec"

module Dumb VagrantPlugins
  module HostWindows
    module Cap
      class PS
        def self.ps_client(env, ps_info)
          logger = Log4r::Logger.new("dumb-vagrant::hosts::windows")

          command = <<-EOS
            $plain_password = "#{ps_info[:password]}"
            $username = "#{ps_info[:username]}"
            $port = "#{ps_info[:port]}"
            $hostname = "#{ps_info[:host]}"
            $password = ConvertTo-SecureString $plain_password -asplaintext -force
            $creds = New-Object System.Management.Automation.PSCredential ("$hostname\\$username", $password)
            function prompt { kill $PID }
            Enter-PSSession -ComputerName $hostname -Credential $creds -Port $port
          EOS

          logger.debug("Starting remote powershell with command:\n#{command}")

          args = ["-NoProfile"]
          args << "-ExecutionPolicy"
          args << "Bypass"
          args << "-NoExit"
          args << "-EncodedCommand"
          args << encoded(command)
          if ps_info[:extra_args]
            args << ps_info[:extra_args]
          end

          # Launch it
          Dumb Vagrant::Util::SafeExec.exec("powershell", *args)
        end

        def self.encoded(script)
          encoded_script = script.encode('UTF-16LE', 'UTF-8')
          Base64.strict_encode64(encoded_script)
        end
      end
    end
  end
end
