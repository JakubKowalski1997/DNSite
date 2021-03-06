package com.dnsite.tsig_keys.model;

import com.dnsite.utils.custom_constraints.letter_case.LetterCaseMode;
import com.dnsite.utils.custom_constraints.letter_case.LetterCase;

import javax.persistence.*;

@Entity
@Table(name = "tsigkeys", indexes = {
        @Index(columnList = "name,algorithm", name="namealgoindex"),
})
public class TsigKeysModel {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long Id;

    @LetterCase(LetterCaseMode.LOWER)
    @Column(name = "name")
    private String name;

    @Column(name = "algorithm")
    private String algorithm;

    @Column(name = "secret")
    private String secret;

    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        Id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAlgorithm() {
        return algorithm;
    }

    public void setAlgorithm(String algorithm) {
        this.algorithm = algorithm;
    }

    public String getSecret() {
        return secret;
    }

    public void setSecret(String secret) {
        this.secret = secret;
    }
}
