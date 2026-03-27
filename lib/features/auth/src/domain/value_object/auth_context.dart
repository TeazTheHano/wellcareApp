enum AuthContextType {
  system,
  tenant,
  project,
}

class AuthContext {
  final AuthContextType type;
  final String? tenantId;
  final String? projectId;

  const AuthContext._({
    required this.type,
    this.tenantId,
    this.projectId,
  });

  const AuthContext.system()
      : this._(type: AuthContextType.system);

  const AuthContext.tenant({
    required String tenantId,
  }) : this._(
          type: AuthContextType.tenant,
          tenantId: tenantId,
        );

  const AuthContext.project({
    required String tenantId,
    required String projectId,
  }) : this._(
          type: AuthContextType.project,
          tenantId: tenantId,
          projectId: projectId,
        );
}
