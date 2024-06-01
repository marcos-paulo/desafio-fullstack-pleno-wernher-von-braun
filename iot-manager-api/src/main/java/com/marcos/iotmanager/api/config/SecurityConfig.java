package com.marcos.iotmanager.api.config;

import static org.springframework.security.config.Customizer.withDefaults;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
  // import static org.springframework.security.config.Customizer.withDefaults;

  @Bean
  public UserDetailsService userDetailsService() {
    // {noop} é necessário para indicar que a senha não está codificada
    UserDetails user = User.withUsername("admin")
        .password("{noop}admin")
        .roles("ROLE").build();

    return new InMemoryUserDetailsManager(user);
  }

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
    http.authorizeHttpRequests(
        authorizeRequests -> authorizeRequests

            .requestMatchers("/swagger-ui.html")
            .permitAll()

            .requestMatchers("/device/**")
            .permitAll()

            .requestMatchers("/teste/**")
            .authenticated()

            .anyRequest()
            .permitAll()
    // .authenticated()
    //
    )
        .httpBasic(withDefaults())

        .sessionManagement(sessionManagement -> sessionManagement
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS))

        .csrf(csrf -> csrf.disable());

    return http.build();
  }
}
