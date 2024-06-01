Consider switching to 'HttpSecurity' Lambda DSL syntaxvscode-spring-boot(JAVA_LAMBDA_DSL)
HttpSecurity org.springframework.security.config.annotation.web.builders.HttpSecurity.authorizeHttpRequests(Customizer<AuthorizationManagerRequestMatcherRegistry> authorizeHttpRequestsCustomizer) throws Exception
Allows restricting access based upon the HttpServletRequest using RequestMatcher implementations (i.e. via URL patterns).

Example Configurations
The most basic example is to configure all URLs to require the role "ROLE_USER". The configuration below requires authentication to every URL and will grant access to both the user "admin" and "user".

```java
@Configuration
@EnableWebSecurity
public class AuthorizeUrlsSecurityConfig {

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http
      .authorizeHttpRequests((authorizeHttpRequests) ->
          authorizeHttpRequests
              .requestMatchers("/**").hasRole("USER")
      )
      .formLogin(withDefaults());
    return http.build();
  }

  @Bean
  public UserDetailsService userDetailsService() {
    UserDetails user = User.withDefaultPasswordEncoder()
      .username("user")
      .password("password")
      .roles("USER")
      .build();
    UserDetails admin = User.withDefaultPasswordEncoder()
      .username("admin")
      .password("password")
      .roles("ADMIN", "USER")
      .build();
    return new InMemoryUserDetailsManager(user, admin);
  }
}

```

We can also configure multiple URLs. The configuration below requires authentication to every URL and will grant access to URLs starting with /admin/ to only the "admin" user. All other URLs either user can access.

```java
@Configuration
@EnableWebSecurity
public class AuthorizeUrlsSecurityConfig {

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http
      .authorizeHttpRequests((authorizeHttpRequests) ->
        authorizeHttpRequests
          .requestMatchers("/admin/**").hasRole("ADMIN")
          .requestMatchers("/**").hasRole("USER")
      )
      .formLogin(withDefaults());
    return http.build();
  }

  @Bean
  public UserDetailsService userDetailsService() {
    UserDetails user = User.withDefaultPasswordEncoder()
      .username("user")
      .password("password")
      .roles("USER")
      .build();
    UserDetails admin = User.withDefaultPasswordEncoder()
      .username("admin")
      .password("password")
      .roles("ADMIN", "USER")
      .build();
    return new InMemoryUserDetailsManager(user, admin);
  }
}

```

Note that the matchers are considered in order. Therefore, the following is invalid because the first matcher matches every request and will never get to the second mapping:

```java
@Configuration
@EnableWebSecurity
public class AuthorizeUrlsSecurityConfig {

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http
      .authorizeHttpRequests((authorizeHttpRequests) ->
        authorizeHttpRequests
          .requestMatchers("/**").hasRole("USER")
          .requestMatchers("/admin/**").hasRole("ADMIN")
      );
    return http.build();
  }
}

```

Parameters:

authorizeHttpRequestsCustomizer the Customizer to provide more options for the AuthorizationManagerRequestMatcherRegistry
Returns:

the HttpSecurity for further customizations
Throws:

Exception
Since:

5.5
