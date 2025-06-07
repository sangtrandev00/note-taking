---
layout: post
title: "Thứ tự validate trong Keycloak"
date: 2025-08-18 10:00:00 +0700
categories: concept-base technical backend nestjs authentication keycloak
tags: ["typescript"]
source_path: "Evergreen/concept-base/technical/backend/nestjs/authentication/keycloak/Thứ tự validate trong Keycloak.md"
---
```typescript

// What happens behind the scenes
const validateRequest = async (request) => {
    // 1. Extract token from request
    const token = request.headers.authorization;

    // 2. Verify token signature and expiration
    const decodedToken = verify(token);

    // 3. Extract roles from token
    const userRoles = decodedToken.realm_access.roles;

    // 4. Check if required roles exist
    const hasRequiredRoles = requiredRoles.every(
        role => userRoles.includes(role)
    );

    return hasRequiredRoles;
}

```


```ts
// Check log khi request gửi tới và response trả về của ứng dụng keycloak
[Nest] 98329  - 02/09/2025, 2:45:02 PM VERBOSE [Keycloak] Using token validation method: ONLINE
[Nest] 98329  - 02/09/2025, 2:45:02 PM VERBOSE [Keycloak] Authenticated User: 
{"exp":1739087316,"iat":1739087016,"jti":"40080699-89d7-435d-9ae3-0854c79967a2","iss":"http://localhost:8080/realms/survey-app","aud":"account","sub":"c09508ae-7f2f-43f4-8587-a83884535528","typ":"Bearer","azp":"survey-client","session_state":"e940dc5b-47dc-43e3-8065-3dc1599221b1","acr":"1","allowed-origins":["http://localhost:3000"],"realm_access":{"roles":["offline_access","uma_authorization","default-roles-survey-app"]},"resource_access":{"survey-client":{"roles":["admin","user"]},"account":{"roles":["manage-account","manage-account-links","view-profile"]}},"scope":"profile email","sid":"e940dc5b-47dc-43e3-8065-3dc1599221b1","email_verified":true,"name":"Sang Tran","preferred_username":"admin","given_name":"Sang","family_name":"Tran","email":"nhatsang0101@gmail.com"}

[Nest] 98329  - 02/09/2025, 2:45:02 PM VERBOSE [Keycloak] Route has no @Scope defined, request allowed due to policy enforcement
[Nest] 98329  - 02/09/2025, 2:45:02 PM VERBOSE [Keycloak] Using matching mode: any
[Nest] 98329  - 02/09/2025, 2:45:02 PM VERBOSE [Keycloak] Roles: ["xyz"]
[Nest] 98329  - 02/09/2025, 2:45:02 PM VERBOSE [Keycloak] Resource denied due to mismatched role(s)


```

---
*Nguồn: Evergreen/concept-base/technical/backend/nestjs/authentication/keycloak/Thứ tự validate trong Keycloak.md*