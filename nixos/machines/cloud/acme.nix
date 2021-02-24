{ config, lib, pkgs, ... }:

{
  security.acme.email = "ac610f0b@nutty.email";
  security.acme.acceptTerms = true;
}
