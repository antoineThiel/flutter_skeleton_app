class GraphQLRoutes {
  static signUp(
      {required String email,
      required String username,
      required String password}) {
    return """
      mutation {
        signUp(email: "$email", username: "$username", password: "$password", role: 1) {
          email
        }
      }
    """;
  }

  static signIn({required String email, required String password}) {
    return """
      mutation {
        signIn(email: "$email", password: "$password")
      }
    """;
  }

  static getUser({required int id}) {
    return """
      query {
        user(id: $id) {
          id
          email
          username
          role {
            id
            name
            is_admin
            description
          }
        }
      }
    """;
  }

  static getUsers() {
    return """
      query {
        user {
          id
          email
          username
          role {
            id
            name
            is_admin
            description
          }
        }
      }
    """;
  }

  static getRole({required int id}) {
    return """
      query {
        role(id: $id) {
          id
          name
          is_admin
          description
        }
      }
    """;
  }

  static getRoles() {
    return """
      query {
        role {
          id
          name
          is_admin
          description
        }
      }
    """;
  }
}
