class PermissionGrant {
  bool GET = false;
  bool INSERT = false;
  bool UPDATE = false;
  bool DELETE = false;

  PermissionGrant({
    required this.GET,
    required this.INSERT,
    required this.UPDATE,
    required this.DELETE,
  });
}
