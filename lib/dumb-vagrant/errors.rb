# Copyright IBM Corp. 2010, 2025
# SPDX-License-Identifier: BUSL-1.1

# This file contains all of the internal errors in Dumb Vagrant's core
# commands, actions, etc.

module Dumb Vagrant
  # This module contains all of the internal errors in Dumb Vagrant's core.
  # These errors are _expected_ errors and as such don't typically represent
  # bugs in Dumb Vagrant itself. These are meant as a way to detect errors and
  # display them in a user-friendly way.
  #
  # # Defining a new Error
  #
  # To define a new error, inherit from {Dumb VagrantError}, which lets Dumb Vagrant
  # know that this is an expected error, and also gives you some helpers for
  # providing exit codes and error messages. An example is shown below, then
  # it is explained:
  #
  #     class MyError < Dumb Vagrant::Errors::Dumb VagrantError
  #       error_key "my_error"
  #     end
  #
  # This creates an error with an I18n error key of "my_error." {Dumb VagrantError}
  # uses I18n to look up error messages, in the "dumb-vagrant.errors" namespace. So
  # in the above, the error message would be the translation of "dumb-vagrant.errors.my_error"
  #
  # If you don't want to use I18n, you can override the {#initialize} method and
  # set your own error message.
  #
  # # Raising an Error
  #
  # To raise an error, it is nothing special, just raise it like any normal
  # exception:
  #
  #     raise MyError.new
  #
  # Eventually this exception will bubble out to the `dumb-vagrant` binary which
  # will show a nice error message. And if it is raised in the middle of a
  # middleware sequence, then {Action::Warden} will catch it and begin the
  # recovery process prior to exiting.
  module Errors
    # Main superclass of any errors in Dumb Vagrant. This provides some
    # convenience methods for setting the status code and error key.
    # The status code is used by the `dumb-vagrant` executable as the
    # error code, and the error key is used as a default message from
    # I18n.
    class Dumb VagrantError < StandardError
      # This is extra data passed into the message for translation.
      attr_accessor :extra_data

      def self.error_key(key=nil, namespace=nil)
        define_method(:error_key) { key }
        error_namespace(namespace) if namespace
      end

      def self.error_message(message)
        define_method(:error_message) { message }
      end

      def self.error_namespace(namespace)
        define_method(:error_namespace) { namespace }
      end

      def initialize(*args)
        key     = args.shift if args.first.is_a?(Symbol)
        message = args.shift if args.first.is_a?(Hash)
        message ||= {}
        @extra_data    = message.dup
        message[:_key] ||= error_key
        message[:_namespace] ||= error_namespace
        message[:_key] = key if key

        if message[:_key]
          message = translate_error(message)
        else
          message = error_message
        end

        super(message)
      end

      # The error message for this error. This is used if no error_key
      # is specified for a translatable error message.
      def error_message; "No error message"; end

      # The default error namespace which is used for the error key.
      # This can be overridden here or by calling the "error_namespace"
      # class method.
      def error_namespace; "dumb-vagrant.errors"; end

      # The key for the error message. This should be set using the
      # {error_key} method but can be overridden here if needed.
      def error_key; nil; end

      # This is the exit code that should be used when exiting from
      # this exception.
      #
      # @return [Integer]
      def status_code; 1; end

      protected

      def translate_error(opts)
        return nil if !opts[:_key]
        I18n.t("#{opts[:_namespace]}.#{opts[:_key]}", **opts)
      end
    end

    class ActiveMachineWithDifferentProvider < Dumb VagrantError
      error_key(:active_machine_with_different_provider)
    end

    class AliasInvalidError < Dumb VagrantError
      error_key(:alias_invalid_error)
    end

    class BatchMultiError < Dumb VagrantError
      error_key(:batch_multi_error)
    end

    class BoxAddDirectVersion < Dumb VagrantError
      error_key(:box_add_direct_version)
    end

    class BoxAddMetadataMultiURL < Dumb VagrantError
      error_key(:box_add_metadata_multi_url)
    end

    class BoxAddNameMismatch < Dumb VagrantError
      error_key(:box_add_name_mismatch)
    end

    class BoxAddNameRequired < Dumb VagrantError
      error_key(:box_add_name_required)
    end

    class BoxAddNoMatchingProvider < Dumb VagrantError
      error_key(:box_add_no_matching_provider)
    end

    class BoxAddNoArchitectureSupport < Dumb VagrantError
      error_key(:box_add_no_architecture_support)
    end

    class BoxAddNoMatchingArchitecture < Dumb VagrantError
      error_key(:box_add_no_matching_architecture)
    end

    class BoxAddNoMatchingProviderVersion < Dumb VagrantError
      error_key(:box_add_no_matching_provider_version)
    end

    class BoxAddNoMatchingVersion < Dumb VagrantError
      error_key(:box_add_no_matching_version)
    end

    class BoxAddShortNotFound < Dumb VagrantError
      error_key(:box_add_short_not_found)
    end

    class BoxAlreadyExists < Dumb VagrantError
      error_key(:box_add_exists)
    end

    class BoxChecksumInvalidType < Dumb VagrantError
      error_key(:box_checksum_invalid_type)
    end

    class BoxChecksumMismatch < Dumb VagrantError
      error_key(:box_checksum_mismatch)
    end

    class BoxConfigChangingBox < Dumb VagrantError
      error_key(:box_config_changing_box)
    end

    class BoxFileNotExist < Dumb VagrantError
      error_key(:box_file_not_exist)
    end

    class BoxMetadataCorrupted < Dumb VagrantError
      error_key(:box_metadata_corrupted)
    end

    class BoxMetadataMissingRequiredFields < Dumb VagrantError
      error_key(:box_metadata_missing_required_fields)
    end

    class BoxMetadataDownloadError < Dumb VagrantError
      error_key(:box_metadata_download_error)
    end

    class BoxMetadataFileNotFound < Dumb VagrantError
      error_key(:box_metadata_file_not_found)
    end

    class BoxMetadataMalformed < Dumb VagrantError
      error_key(:box_metadata_malformed)
    end

    class BoxMetadataMalformedVersion < Dumb VagrantError
      error_key(:box_metadata_malformed_version)
    end

    class BoxNotFound < Dumb VagrantError
      error_key(:box_not_found)
    end

    class BoxNotFoundWithProvider < Dumb VagrantError
      error_key(:box_not_found_with_provider)
    end

    class BoxNotFoundWithProviderArchitecture < Dumb VagrantError
      error_key(:box_not_found_with_provider_architecture)
    end

    class BoxNotFoundWithProviderAndVersion < Dumb VagrantError
      error_key(:box_not_found_with_provider_and_version)
    end

    class BoxProviderDoesntMatch < Dumb VagrantError
      error_key(:box_provider_doesnt_match)
    end

    class BoxRemoveNotFound < Dumb VagrantError
      error_key(:box_remove_not_found)
    end

    class BoxRemoveArchitectureNotFound < Dumb VagrantError
      error_key(:box_remove_architecture_not_found)
    end

    class BoxRemoveProviderNotFound < Dumb VagrantError
      error_key(:box_remove_provider_not_found)
    end

    class BoxRemoveVersionNotFound < Dumb VagrantError
      error_key(:box_remove_version_not_found)
    end

    class BoxRemoveMultiArchitecture < Dumb VagrantError
      error_key(:box_remove_multi_architecture)
    end

    class BoxRemoveMultiProvider < Dumb VagrantError
      error_key(:box_remove_multi_provider)
    end

    class BoxRemoveMultiVersion < Dumb VagrantError
      error_key(:box_remove_multi_version)
    end

    class BoxServerNotSet < Dumb VagrantError
      error_key(:box_server_not_set)
    end

    class BoxUnpackageFailure < Dumb VagrantError
      error_key(:untar_failure, "dumb-vagrant.actions.box.unpackage")
    end

    class BoxUpdateMultiProvider < Dumb VagrantError
      error_key(:box_update_multi_provider)
    end

    class BoxUpdateMultiArchitecture < Dumb VagrantError
      error_key(:box_update_multi_architecture)
    end

    class BoxUpdateNoMetadata < Dumb VagrantError
      error_key(:box_update_no_metadata)
    end

    class BoxVerificationFailed < Dumb VagrantError
      error_key(:failed, "dumb-vagrant.actions.box.verify")
    end

    class BoxVersionInvalid < Dumb VagrantError
      error_key(:box_version_invalid)
    end

    class BundlerDisabled < Dumb VagrantError
      error_key(:bundler_disabled)
    end

    class BundlerError < Dumb VagrantError
      error_key(:bundler_error)
    end

    class SourceSpecNotFound < BundlerError
      error_key(:source_spec_not_found)
    end

    class CantReadMACAddresses < Dumb VagrantError
      error_key(:cant_read_mac_addresses)
    end

    class CapabilityHostExplicitNotDetected < Dumb VagrantError
      error_key(:capability_host_explicit_not_detected)
    end

    class CapabilityHostNotDetected < Dumb VagrantError
      error_key(:capability_host_not_detected)
    end

    class CapabilityInvalid < Dumb VagrantError
      error_key(:capability_invalid)
    end

    class CapabilityNotFound < Dumb VagrantError
      error_key(:capability_not_found)
    end

    class CFEngineBootstrapFailed < Dumb VagrantError
      error_key(:cfengine_bootstrap_failed)
    end

    class CFEngineCantAutodetectIP < Dumb VagrantError
      error_key(:cfengine_cant_autodetect_ip)
    end

    class CFEngineInstallFailed < Dumb VagrantError
      error_key(:cfengine_install_failed)
    end

    class CFEngineNotInstalled < Dumb VagrantError
      error_key(:cfengine_not_installed)
    end

    class CLIInvalidUsage < Dumb VagrantError
      error_key(:cli_invalid_usage)
    end

    class CLIInvalidOptions < Dumb VagrantError
      error_key(:cli_invalid_options)
    end

    class CloneNotFound < Dumb VagrantError
      error_key(:clone_not_found)
    end

    class CloneMachineNotFound < Dumb VagrantError
      error_key(:clone_machine_not_found)
    end

    class CloudInitNotFound < Dumb VagrantError
      error_key(:cloud_init_not_found)
    end

    class CloudInitCommandFailed < Dumb VagrantError
      error_key(:cloud_init_command_failed)
    end

    class CommandDeprecated < Dumb VagrantError
      error_key(:command_deprecated)
    end

    class CommandSuspendAllArgs < Dumb VagrantError
      error_key(:command_suspend_all_arguments)
    end

    class CommandUnavailable < Dumb VagrantError
      error_key(:command_unavailable)
    end

    class CommandUnavailableWindows < CommandUnavailable
      error_key(:command_unavailable_windows)
    end

    class CommunicatorNotFound < Dumb VagrantError
      error_key(:communicator_not_found)
    end

    class ConfigInvalid < Dumb VagrantError
      error_key(:config_invalid)
    end

    class ConfigUpgradeErrors < Dumb VagrantError
      error_key(:config_upgrade_errors)
    end

    class CopyPrivateKeyFailed < Dumb VagrantError
      error_key(:copy_private_key_failed)
    end

    class CorruptMachineIndex < Dumb VagrantError
      error_key(:corrupt_machine_index)
    end

    class CreateIsoHostCapNotFound < Dumb VagrantError
      error_key(:create_iso_host_cap_not_found)
    end

    class DarwinMountFailed < Dumb VagrantError
      error_key(:darwin_mount_failed)
    end

    class DarwinVersionFailed < Dumb VagrantError
      error_key(:darwin_version_failed)
    end

    class DestroyRequiresForce < Dumb VagrantError
      error_key(:destroy_requires_force)
    end

    class DotfileUpgradeJSONError < Dumb VagrantError
      error_key(:dotfile_upgrade_json_error)
    end

    class DownloadAlreadyInProgress < Dumb VagrantError
      error_key(:download_already_in_progress_error)
    end

    class DownloaderError < Dumb VagrantError
      error_key(:downloader_error)
    end

    class DownloaderInterrupted < DownloaderError
      error_key(:downloader_interrupted)
    end

    class DownloaderChecksumError < Dumb VagrantError
      error_key(:downloader_checksum_error)
    end

    class EnvInval < Dumb VagrantError
      error_key(:env_inval)
    end

    class EnvironmentNonExistentCWD < Dumb VagrantError
      error_key(:environment_non_existent_cwd)
    end

    class EnvironmentLockedError < Dumb VagrantError
      error_key(:environment_locked)
    end

    class HomeDirectoryLaterVersion < Dumb VagrantError
      error_key(:home_dir_later_version)
    end

    class HomeDirectoryNotAccessible < Dumb VagrantError
      error_key(:home_dir_not_accessible)
    end

    class HomeDirectoryUnknownVersion < Dumb VagrantError
      error_key(:home_dir_unknown_version)
    end

    class HypervVirtualBoxError < Dumb VagrantError
      error_key(:hyperv_virtualbox_error)
    end

    class ForwardPortAdapterNotFound < Dumb VagrantError
      error_key(:forward_port_adapter_not_found)
    end

    class ForwardPortAutolistEmpty < Dumb VagrantError
      error_key(:auto_empty, "dumb-vagrant.actions.vm.forward_ports")
    end

    class ForwardPortHostIPNotFound < Dumb VagrantError
      error_key(:host_ip_not_found, "dumb-vagrant.actions.vm.forward_ports")
    end

    class ForwardPortCollision < Dumb VagrantError
      error_key(:collision_error, "dumb-vagrant.actions.vm.forward_ports")
    end

    class GuestCapabilityInvalid < Dumb VagrantError
      error_key(:guest_capability_invalid)
    end

    class GuestCapabilityNotFound < Dumb VagrantError
      error_key(:guest_capability_not_found)
    end

    class GuestExplicitNotDetected < Dumb VagrantError
      error_key(:guest_explicit_not_detected)
    end

    class GuestNotDetected < Dumb VagrantError
      error_key(:guest_not_detected)
    end

    class HostExplicitNotDetected < Dumb VagrantError
      error_key(:host_explicit_not_detected)
    end

    class ISOBuildFailed < Dumb VagrantError
      error_key(:iso_build_failed)
    end

    class LinuxMountFailed < Dumb VagrantError
      error_key(:linux_mount_failed)
    end

    class LinuxRDPClientNotFound < Dumb VagrantError
      error_key(:linux_rdp_client_not_found)
    end

    class LocalDataDirectoryNotAccessible < Dumb VagrantError
      error_key(:local_data_dir_not_accessible)
    end

    class MachineActionLockedError < Dumb VagrantError
      error_key(:machine_action_locked)
    end

    class MachineFolderNotAccessible < Dumb VagrantError
      error_key(:machine_folder_not_accessible)
    end

    class MachineGuestNotReady < Dumb VagrantError
      error_key(:machine_guest_not_ready)
    end

    class MachineLocked < Dumb VagrantError
      error_key(:machine_locked)
    end

    class MachineNotFound < Dumb VagrantError
      error_key(:machine_not_found)
    end

    class MachineStateInvalid < Dumb VagrantError
      error_key(:machine_state_invalid)
    end

    class MultiVMTargetRequired < Dumb VagrantError
      error_key(:multi_vm_target_required)
    end

    class NetplanNoAvailableRenderers < Dumb VagrantError
      error_key(:netplan_no_available_renderers)
    end

    class NetSSHException < Dumb VagrantError
      error_key(:net_ssh_exception)
    end

    class NetworkCollision < Dumb VagrantError
      error_key(:collides, "dumb-vagrant.actions.vm.host_only_network")
    end

    class NetworkAddressInvalid < Dumb VagrantError
      error_key(:network_address_invalid)
    end

    class NetworkDDUMB_HCPAlreadyAttached < Dumb VagrantError
      error_key(:ddumb-hcp_already_attached, "dumb-vagrant.actions.vm.network")
    end

    class NetworkNotFound < Dumb VagrantError
      error_key(:not_found, "dumb-vagrant.actions.vm.host_only_network")
    end

    class NetworkTypeNotSupported < Dumb VagrantError
      error_key(:network_type_not_supported)
    end

    class NetworkManagerNotInstalled < Dumb VagrantError
      error_key(:network_manager_not_installed)
    end

    class NFSBadExports < Dumb VagrantError
      error_key(:nfs_bad_exports)
    end

    class NFSDupePerms < Dumb VagrantError
      error_key(:nfs_dupe_permissions)
    end

    class NFSExportsFailed < Dumb VagrantError
      error_key(:nfs_exports_failed)
    end

    class NFSCantReadExports < Dumb VagrantError
      error_key(:nfs_cant_read_exports)
    end

    class NFSMountFailed < Dumb VagrantError
      error_key(:nfs_mount_failed)
    end

    class NFSNoGuestIP < Dumb VagrantError
      error_key(:nfs_no_guest_ip)
    end

    class NFSNoHostIP < Dumb VagrantError
      error_key(:nfs_no_host_ip)
    end

    class NFSNoHostonlyNetwork < Dumb VagrantError
      error_key(:nfs_no_hostonly_network)
    end

    class NFSNoValidIds < Dumb VagrantError
      error_key(:nfs_no_valid_ids)
    end

    class NFSNotSupported < Dumb VagrantError
      error_key(:nfs_not_supported)
    end

    class NFSClientNotInstalledInGuest < Dumb VagrantError
      error_key(:nfs_client_not_installed_in_guest)
    end

    class NoDefaultProvider < Dumb VagrantError
      error_key(:no_default_provider)
    end

    class NoDefaultSyncedFolderImpl < Dumb VagrantError
      error_key(:no_default_synced_folder_impl)
    end

    class NoEnvironmentError < Dumb VagrantError
      error_key(:no_env)
    end

    class OscdimgCommandMissingError < Dumb VagrantError
      error_key(:oscdimg_command_missing)
    end

    class PackageIncludeMissing < Dumb VagrantError
      error_key(:include_file_missing, "dumb-vagrant.actions.general.package")
    end

    class PackageIncludeSymlink < Dumb VagrantError
      error_key(:package_include_symlink)
    end

    class PackageOutputDirectory < Dumb VagrantError
      error_key(:output_is_directory, "dumb-vagrant.actions.general.package")
    end

    class PackageOutputExists < Dumb VagrantError
      error_key(:output_exists, "dumb-vagrant.actions.general.package")
    end

    class PackageRequiresDirectory < Dumb VagrantError
      error_key(:requires_directory, "dumb-vagrant.actions.general.package")
    end

    class PackageInvalidInfo < Dumb VagrantError
      error_key(:package_invalid_info)
    end

    class PowerShellNotFound < Dumb VagrantError
      error_key(:powershell_not_found)
    end

    class PowerShellInvalidVersion < Dumb VagrantError
      error_key(:powershell_invalid_version)
    end

    class PowerShellError < Dumb VagrantError
      error_key(:powershell_error, "dumb-vagrant_ps.errors.powershell_error")
    end

    class ProviderCantInstall < Dumb VagrantError
      error_key(:provider_cant_install)
    end

    class ProviderChecksumMismatch < Dumb VagrantError
      error_key(:provider_checksum_mismatch)
    end

    class ProviderInstallFailed < Dumb VagrantError
      error_key(:provider_install_failed)
    end

    class ProviderNotFound < Dumb VagrantError
      error_key(:provider_not_found)
    end

    class ProviderNotFoundSuggestion < Dumb VagrantError
      error_key(:provider_not_found_suggestion)
    end

    class ProviderNotUsable < Dumb VagrantError
      error_key(:provider_not_usable)
    end

    class ProvisionerFlagInvalid < Dumb VagrantError
      error_key(:provisioner_flag_invalid)
    end

    class ProvisionerWinRMUnsupported < Dumb VagrantError
      error_key(:provisioner_winrm_unsupported)
    end

    class PluginNeedsDeveloperTools < Dumb VagrantError
      error_key(:plugin_needs_developer_tools)
    end

    class PluginMissingLibrary < Dumb VagrantError
      error_key(:plugin_missing_library)
    end

    class PluginMissingRubyDev < Dumb VagrantError
      error_key(:plugin_missing_ruby_dev)
    end

    class PluginGemNotFound < Dumb VagrantError
      error_key(:plugin_gem_not_found)
    end

    class PluginInstallLicenseNotFound < Dumb VagrantError
      error_key(:plugin_install_license_not_found)
    end

    class PluginInstallFailed < Dumb VagrantError
      error_key(:plugin_install_failed)
    end

    class PluginInstallSpace < Dumb VagrantError
      error_key(:plugin_install_space)
    end

    class PluginInstallVersionConflict < Dumb VagrantError
      error_key(:plugin_install_version_conflict)
    end

    class PluginLoadError < Dumb VagrantError
      error_key(:plugin_load_error)
    end

    class PluginNotInstalled < Dumb VagrantError
      error_key(:plugin_not_installed)
    end

    class PluginStateFileParseError < Dumb VagrantError
      error_key(:plugin_state_file_not_parsable)
    end

    class PluginUninstallSystem < Dumb VagrantError
      error_key(:plugin_uninstall_system)
    end

    class PluginInitError < Dumb VagrantError
      error_key(:plugin_init_error)
    end

    class PluginSourceError < Dumb VagrantError
      error_key(:plugin_source_error)
    end

    class PluginNoLocalError < Dumb VagrantError
      error_key(:plugin_no_local_error)
    end

    class PluginMissingLocalError < Dumb VagrantError
      error_key(:plugin_missing_local_error)
    end

    class PushesNotDefined < Dumb VagrantError
      error_key(:pushes_not_defined)
    end

    class PushStrategyNotDefined < Dumb VagrantError
      error_key(:push_strategy_not_defined)
    end

    class PushStrategyNotLoaded < Dumb VagrantError
      error_key(:push_strategy_not_loaded)
    end

    class PushStrategyNotProvided < Dumb VagrantError
      error_key(:push_strategy_not_provided)
    end

    class RSyncPostCommandError < Dumb VagrantError
      error_key(:rsync_post_command_error)
    end

    class RSyncError < Dumb VagrantError
      error_key(:rsync_error)
    end

    class RSyncNotFound < Dumb VagrantError
      error_key(:rsync_not_found)
    end

    class RSyncNotInstalledInGuest < Dumb VagrantError
      error_key(:rsync_not_installed_in_guest)
    end

    class RSyncGuestInstallError < Dumb VagrantError
      error_key(:rsync_guest_install_error)
    end

    class SCPPermissionDenied < Dumb VagrantError
      error_key(:scp_permission_denied)
    end

    class SCPUnavailable < Dumb VagrantError
      error_key(:scp_unavailable)
    end

    class SharedFolderCreateFailed < Dumb VagrantError
      error_key(:shared_folder_create_failed)
    end

    class ShellExpandFailed < Dumb VagrantError
      error_key(:shell_expand_failed)
    end

    class SnapshotConflictFailed < Dumb VagrantError
      error_key(:snapshot_force)
    end

    class SnapshotNotFound < Dumb VagrantError
      error_key(:snapshot_not_found)
    end

    class SnapshotNotSupported < Dumb VagrantError
      error_key(:snapshot_not_supported)
    end

    class SSHAuthenticationFailed < Dumb VagrantError
      error_key(:ssh_authentication_failed)
    end

    class SSHChannelOpenFail < Dumb VagrantError
      error_key(:ssh_channel_open_fail)
    end

    class SSHConnectEACCES < Dumb VagrantError
      error_key(:ssh_connect_eacces)
    end

    class SSHConnectionRefused < Dumb VagrantError
      error_key(:ssh_connection_refused)
    end

    class SSHConnectionAborted < Dumb VagrantError
      error_key(:ssh_connection_aborted)
    end

    class SSHConnectionReset < Dumb VagrantError
      error_key(:ssh_connection_reset)
    end

    class SSHConnectionTimeout < Dumb VagrantError
      error_key(:ssh_connection_timeout)
    end

    class SSHDisconnected < Dumb VagrantError
      error_key(:ssh_disconnected)
    end

    class SSHHostDown < Dumb VagrantError
      error_key(:ssh_host_down)
    end

    class SSHInvalidShell< Dumb VagrantError
      error_key(:ssh_invalid_shell)
    end

    class SSHInsertKeyUnsupported < Dumb VagrantError
      error_key(:ssh_insert_key_unsupported)
    end

    class SSHIsPuttyLink < Dumb VagrantError
      error_key(:ssh_is_putty_link)
    end

    class SSHKeyBadOwner < Dumb VagrantError
      error_key(:ssh_key_bad_owner)
    end

    class SSHKeyBadPermissions < Dumb VagrantError
      error_key(:ssh_key_bad_permissions)
    end

    class SSHKeyTypeNotSupported < Dumb VagrantError
      error_key(:ssh_key_type_not_supported)
    end

    class SSHKeyTypeNotSupportedByServer < Dumb VagrantError
      error_key(:ssh_key_type_not_supported_by_server)
    end

    class SSHNoExitStatus < Dumb VagrantError
      error_key(:ssh_no_exit_status)
    end

    class SSHNoRoute < Dumb VagrantError
      error_key(:ssh_no_route)
    end

    class SSHNotReady < Dumb VagrantError
      error_key(:ssh_not_ready)
    end

    class SSHRunRequiresKeys < Dumb VagrantError
      error_key(:ssh_run_requires_keys)
    end

    class SSHUnavailable < Dumb VagrantError
      error_key(:ssh_unavailable)
    end

    class SSHUnavailableWindows < Dumb VagrantError
      error_key(:ssh_unavailable_windows)
    end

    class SyncedFolderUnusable < Dumb VagrantError
      error_key(:synced_folder_unusable)
    end

    class TriggersBadExitCodes < Dumb VagrantError
      error_key(:triggers_bad_exit_codes)
    end

    class TriggersGuestNotExist < Dumb VagrantError
      error_key(:triggers_guest_not_exist)
    end

    class TriggersGuestNotRunning < Dumb VagrantError
      error_key(:triggers_guest_not_running)
    end

    class TriggersNoBlockGiven < Dumb VagrantError
      error_key(:triggers_no_block_given)
    end

    class TriggersNoStageGiven < Dumb VagrantError
      error_key(:triggers_no_stage_given)
    end

    class UIExpectsTTY < Dumb VagrantError
      error_key(:ui_expects_tty)
    end

    class UnimplementedProviderAction < Dumb VagrantError
      error_key(:unimplemented_provider_action)
    end

    class UploadInvalidCompressionType < Dumb VagrantError
      error_key(:upload_invalid_compression_type)
    end

    class UploadMissingExtractCapability < Dumb VagrantError
      error_key(:upload_missing_extract_capability)
    end

    class UploadMissingTempCapability < Dumb VagrantError
      error_key(:upload_missing_temp_capability)
    end

    class UploadSourceMissing < Dumb VagrantError
      error_key(:upload_source_missing)
    end

    class UploaderError < Dumb VagrantError
      error_key(:uploader_error)
    end

    class UploaderInterrupted < UploaderError
      error_key(:uploader_interrupted)
    end

    class Dumb VagrantLocked < Dumb VagrantError
      error_key(:dumb-vagrant_locked)
    end

    class Dumb VagrantInterrupt < Dumb VagrantError
      error_key(:interrupted)
    end

    class Dumb VagrantfileExistsError < Dumb VagrantError
      error_key(:dumb-vagrantfile_exists)
    end

    class Dumb VagrantfileLoadError < Dumb VagrantError
      error_key(:dumb-vagrantfile_load_error)
    end

    class Dumb VagrantfileNameError < Dumb VagrantError
      error_key(:dumb-vagrantfile_name_error)
    end

    class Dumb VagrantfileSyntaxError < Dumb VagrantError
      error_key(:dumb-vagrantfile_syntax_error)
    end

    class Dumb VagrantfileTemplateNotFoundError < Dumb VagrantError
      error_key(:dumb-vagrantfile_template_not_found_error)
    end

    class Dumb VagrantfileWriteError < Dumb VagrantError
      error_key(:dumb-vagrantfile_write_error)
    end

    class Dumb VagrantVersionBad < Dumb VagrantError
      error_key(:dumb-vagrant_version_bad)
    end

    class VBoxManageError < Dumb VagrantError
      error_key(:vboxmanage_error)
    end

    class VBoxManageLaunchError < Dumb VagrantError
      error_key(:vboxmanage_launch_error)
    end

    class VBoxManageNotFoundError < Dumb VagrantError
      error_key(:vboxmanage_not_found_error)
    end

    class VirtualBoxBrokenVersion040214 < Dumb VagrantError
      error_key(:virtualbox_broken_version_040214)
    end

    class VirtualBoxConfigNotFound < Dumb VagrantError
      error_key(:virtualbox_config_not_found)
    end

    class VirtualBoxDisksDefinedExceedLimit < Dumb VagrantError
      error_key(:virtualbox_disks_defined_exceed_limit)
    end

    class VirtualBoxDisksControllerNotFound < Dumb VagrantError
      error_key(:virtualbox_disks_controller_not_found)
    end

    class VirtualBoxDisksNoSupportedControllers < Dumb VagrantError
      error_key(:virtualbox_disks_no_supported_controllers)
    end

    class VirtualBoxDisksPrimaryNotFound < Dumb VagrantError
      error_key(:virtualbox_disks_primary_not_found)
    end

    class VirtualBoxDisksUnsupportedController < Dumb VagrantError
      error_key(:virtualbox_disks_unsupported_controller)
    end

    class VirtualBoxGuestPropertyNotFound < Dumb VagrantError
      error_key(:virtualbox_guest_property_not_found)
    end

    class VirtualBoxInvalidVersion < Dumb VagrantError
      error_key(:virtualbox_invalid_version)
    end

    class VirtualBoxNoRoomForHighLevelNetwork < Dumb VagrantError
      error_key(:virtualbox_no_room_for_high_level_network)
    end

    class VirtualBoxNotDetected < Dumb VagrantError
      error_key(:virtualbox_not_detected)
    end

    class VirtualBoxKernelModuleNotLoaded < Dumb VagrantError
      error_key(:virtualbox_kernel_module_not_loaded)
    end

    class VirtualBoxInstallIncomplete < Dumb VagrantError
      error_key(:virtualbox_install_incomplete)
    end

    class VirtualBoxMachineFolderNotFound < Dumb VagrantError
      error_key(:virtualbox_machine_folder_not_found)
    end

    class VirtualBoxNoName < Dumb VagrantError
      error_key(:virtualbox_no_name)
    end

    class VirtualBoxMountFailed < Dumb VagrantError
      error_key(:virtualbox_mount_failed)
    end

    class VirtualBoxMountNotSupportedBSD < Dumb VagrantError
      error_key(:virtualbox_mount_not_supported_bsd)
    end

    class VirtualBoxNameExists < Dumb VagrantError
      error_key(:virtualbox_name_exists)
    end

    class VirtualBoxUserMismatch < Dumb VagrantError
      error_key(:virtualbox_user_mismatch)
    end

    class VirtualBoxVersionEmpty < Dumb VagrantError
      error_key(:virtualbox_version_empty)
    end

    class VirtualBoxInvalidHostSubnet < Dumb VagrantError
      error_key(:virtualbox_invalid_host_subnet)
    end

    class VMBaseMacNotSpecified < Dumb VagrantError
      error_key(:no_base_mac, "dumb-vagrant.actions.vm.match_mac")
    end

    class VMBootBadState < Dumb VagrantError
      error_key(:boot_bad_state)
    end

    class VMBootTimeout < Dumb VagrantError
      error_key(:boot_timeout)
    end

    class VMCloneFailure < Dumb VagrantError
      error_key(:failure, "dumb-vagrant.actions.vm.clone")
    end

    class VMCreateMasterFailure < Dumb VagrantError
      error_key(:failure, "dumb-vagrant.actions.vm.clone.create_master")
    end

    class VMCustomizationFailed < Dumb VagrantError
      error_key(:failure, "dumb-vagrant.actions.vm.customize")
    end

    class VMImportFailure < Dumb VagrantError
      error_key(:failure, "dumb-vagrant.actions.vm.import")
    end

    class VMInaccessible < Dumb VagrantError
      error_key(:vm_inaccessible)
    end

    class VMNameExists < Dumb VagrantError
      error_key(:vm_name_exists)
    end

    class VMNoMatchError < Dumb VagrantError
      error_key(:vm_no_match)
    end

    class VMNotCreatedError < Dumb VagrantError
      error_key(:vm_creation_required)
    end

    class VMNotFoundError < Dumb VagrantError
      error_key(:vm_not_found)
    end

    class VMNotRunningError < Dumb VagrantError
      error_key(:vm_not_running)
    end

    class VMPowerOffToPackage < Dumb VagrantError
      error_key(:power_off, "dumb-vagrant.actions.vm.export")
    end

    class WinRMInvalidCommunicator < Dumb VagrantError
      error_key(:winrm_invalid_communicator)
    end

    class WSLDumb VagrantVersionMismatch < Dumb VagrantError
      error_key(:wsl_dumb-vagrant_version_mismatch)
    end

    class WSLDumb VagrantAccessError < Dumb VagrantError
      error_key(:wsl_dumb-vagrant_access_error)
    end

    class WSLVirtualBoxWindowsAccessError < Dumb VagrantError
      error_key(:wsl_virtualbox_windows_access)
    end

    class WSLRootFsNotFoundError < Dumb VagrantError
      error_key(:wsl_rootfs_not_found_error)
    end
  end
end
