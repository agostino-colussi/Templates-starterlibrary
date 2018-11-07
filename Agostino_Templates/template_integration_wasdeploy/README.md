# WebSphere Application Deploy Template
Copyright IBM Corp. 2018, 2018
This code is released under the Apache 2.0 License.

## Warning

- Built for a POC only with minimal testing.
- Download sample Websphere application from http://public.dhe.ibm.com/software/websphere/appserv/library/v80/samples/ServletSamples.zip
- Example location for the WAS application installation EAR: http://9.42.134.160:8888/WebcontainerSample.ear
- Copy to the /opt/ibm/docker/software-repo/var/swRepo/public directory on the Content Runtime

## Description

This template will deploy a WebSphere application to an existing WebSphere Installation.

## Integration Method

Script Remote, executes on the remote host.

## Orchestration Reccomendation

This template must be executed after the successful creation of a Virtual Machine via a Terraform Template.
WebSphere must already be installed and an AdminApplication running in the cell, for example, a DMGR or
server1 for single node installation.

## Methods Implemented

- **on_create** Installs and starts a WebSphere application.
- **on_delete** Not implemented.

## Prerequisites

- WebSphere installed and an AdminApp running.
- soap.client.props contains the encrypted admin permissions to access the AdminApp
- The target already created, eg a Cluster and an Application Server
- The Application (EAR or WAR) file must be available for access via a URI, eg, http://9.42.134.160:8888/WebcontainerSample.ear

## Input Parameters

<table>
  <tr>
    <th>Variable</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>ip_address</td>
    <td>IP Address of the target server.</td>
  </tr>
  <tr>
    <td>user</td>
    <td>User on the target server to execute the installation.</td>
  </tr>
  <tr>
    <td>password</td>
    <td>Password of the user.</td>
  </tr>
  <tr>
    <td>was_install_profile_dir</td>
    <td>Directory of the profile which houses the AdminApp (Eg /opt/IBM/WebSphere/AppServer/profiles/AppSrv01)</td>
  </tr>
  <tr>
    <td>was_user</td>
    <td>The WebSphere Admin User, eg, wasadmin.</td>
  </tr>
  <tr>
    <td>app_uri</td>
    <td>URI Location of the EAR or WAR file, eg http://9.42.134.160:8888/WebcontainerSample.ear </td>
  </tr>
  <tr>
    <td>target_type</td>
    <td>Target type, eg, cluster or server</td>
  </tr>
  <tr>
    <td>node_name</td>
    <td>Name of the node for the target server, only applicable for a server install, eg, camc-vm209Node01</td>
  </tr>
  <tr>
    <td>target_name</td>
    <td>Name of the deployment target, eg, server1</td>
  </tr>
  <tr>
    <td>app_name</td>
    <td>Name of the application, eg, WebcontainerSample</td>
  </tr>
</table>
