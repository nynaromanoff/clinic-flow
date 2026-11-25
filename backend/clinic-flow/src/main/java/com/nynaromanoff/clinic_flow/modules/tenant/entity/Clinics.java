package com.nynaromanoff.clinic_flow.modules.tenant.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;
import java.util.UUID;

@Entity
@Table(name = "clinics")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Clinics {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private UUID id;

    @NonNull
    private String name;

    @NonNull
    private String slug;

    private Boolean active;

    private Date createdAt;
}
