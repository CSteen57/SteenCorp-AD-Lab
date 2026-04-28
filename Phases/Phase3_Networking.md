# Phase 3 – Networking & Domain Connectivity (In Progress)

## Status
🚧 Currently in development

## Objective
Build and validate core networking functionality within the SteenCorp lab environment.

---

## SteenCorp IP Schema

Before implementation, a structured IP Address Management (IPAM) plan was created to simulate a real-world enterprise network design.

| Category              | Range / Address        | Purpose                                  |
|----------------------|----------------------|------------------------------------------|
| Network              | 192.168.10.0/24      | Core lab subnet (254 usable addresses)   |
| Gateway              | 192.168.10.1         | Default gateway (VMware virtual router)  |
| Domain Controller    | 192.168.10.10        | Active Directory + DNS Server            |
| DNS Server           | 192.168.10.10        | Primary DNS (hosted on Domain Controller)|
| Static Range         | 192.168.10.1–99      | Reserved for infrastructure devices      |
| DHCP Range           | 192.168.10.100–200   | Dynamic allocation for client machines   |

### Design Notes
- Infrastructure devices use static IPs to ensure consistent availability
- Clients receive IP addresses dynamically via DHCP
- DNS is centralized on the Domain Controller for domain resolution
- Subnetting follows a structured allocation model to support scalability

---

## Planned Components
- DNS (Domain Name System) configuration and validation
- Client-to-domain controller communication
- IP addressing and connectivity testing
- Domain join verification
- Network troubleshooting scenarios

## Planned Validation
- Ping tests between client and server
- DNS resolution (nslookup)
- Domain authentication checks
- Network path verification

## Notes
This phase is focused on demonstrating a strong understanding of how systems communicate within an enterprise network, particularly how clients locate and authenticate with domain services.

## Upcoming Evidence
Screenshots and validation outputs will be added upon completion.
