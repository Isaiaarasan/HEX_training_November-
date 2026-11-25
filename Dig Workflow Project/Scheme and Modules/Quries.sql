DROP DATABASE IF EXISTS Gig_workflow;
CREATE DATABASE Gig_workflow;
USE Gig_workflow;

CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(30) NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE client (
    client_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    company_name VARCHAR(255),
    PRIMARY KEY (user_id, client_id),
    UNIQUE KEY uq_client_id (client_id),
    UNIQUE KEY uq_client_user (user_id),
    CONSTRAINT fk_client_user
        FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE freelancer (
    freelancer_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    bio TEXT,
    hourly_rate DECIMAL(10,2),
    experience_years INT,
    PRIMARY KEY (user_id, freelancer_id),
    UNIQUE KEY uq_freelancer_id (freelancer_id),
    UNIQUE KEY uq_freelancer_user (user_id),
    CONSTRAINT fk_freelancer_user
        FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

CREATE TABLE skills (
    skill_id INT NOT NULL AUTO_INCREMENT,
    skill_name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (skill_id)
) ENGINE=InnoDB;

CREATE TABLE freelancer_skills (
    freelancer_user_id INT NOT NULL,
    freelancer_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (freelancer_user_id, freelancer_id, skill_id),
    CONSTRAINT fk_freelancer_skills_freelancer
        FOREIGN KEY (freelancer_user_id, freelancer_id)
        REFERENCES freelancer(user_id, freelancer_id),
    CONSTRAINT fk_freelancer_skills_skill
        FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
) ENGINE=InnoDB;

CREATE TABLE jobs (
    client_user_id INT NOT NULL,
    client_id INT NOT NULL,
    job_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    PRIMARY KEY (client_user_id, client_id, job_id),
    UNIQUE KEY uq_job_id (job_id),
    CONSTRAINT fk_jobs_client
        FOREIGN KEY (client_user_id, client_id)
        REFERENCES client(user_id, client_id),
    CONSTRAINT chk_jobs_budget CHECK (budget > 0)
) ENGINE=InnoDB;

CREATE TABLE job_skills (
    client_user_id INT NOT NULL,
    client_id INT NOT NULL,
    job_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (client_user_id, client_id, job_id, skill_id),
    CONSTRAINT fk_job_skills_job
        FOREIGN KEY (client_user_id, client_id, job_id)
        REFERENCES jobs(client_user_id, client_id, job_id),
    CONSTRAINT fk_job_skills_skill
        FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
) ENGINE=InnoDB;

CREATE TABLE proposals (
    client_user_id INT NOT NULL,
    client_id INT NOT NULL,
    job_id INT NOT NULL,
    freelancer_user_id INT NOT NULL,
    freelancer_id INT NOT NULL,
    proposal_id INT NOT NULL AUTO_INCREMENT,
    proposed_amount DECIMAL(10,2) NOT NULL,
    cover_letter TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    PRIMARY KEY (
        client_user_id, client_id, job_id,
        freelancer_user_id, freelancer_id, proposal_id
    ),
    UNIQUE KEY uq_proposal_id (proposal_id),
    UNIQUE KEY uq_proposal_job_freelancer (
        client_user_id, client_id, job_id,
        freelancer_user_id, freelancer_id
    ),
    CONSTRAINT fk_proposals_job
        FOREIGN KEY (client_user_id, client_id, job_id)
        REFERENCES jobs(client_user_id, client_id, job_id),
    CONSTRAINT fk_proposals_freelancer
        FOREIGN KEY (freelancer_user_id, freelancer_id)
        REFERENCES freelancer(user_id, freelancer_id),
    CONSTRAINT chk_proposals_amount CHECK (proposed_amount > 0)
) ENGINE=InnoDB;

CREATE TABLE contracts (
    client_user_id INT NOT NULL,
    client_id INT NOT NULL,
    job_id INT NOT NULL,
    freelancer_user_id INT NOT NULL,
    freelancer_id INT NOT NULL,
    proposal_id INT NOT NULL,
    contract_id INT NOT NULL AUTO_INCREMENT,
    agreed_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    PRIMARY KEY (
        client_user_id, client_id, job_id,
        freelancer_user_id, freelancer_id, proposal_id, contract_id
    ),
    UNIQUE KEY uq_contract_id (contract_id),
    UNIQUE KEY uq_contract_proposal (
        client_user_id, client_id, job_id,
        freelancer_user_id, freelancer_id, proposal_id
    ),
    CONSTRAINT fk_contracts_proposal
        FOREIGN KEY (
            client_user_id, client_id, job_id,
            freelancer_user_id, freelancer_id, proposal_id
        )
        REFERENCES proposals (
            client_user_id, client_id, job_id,
            freelancer_user_id, freelancer_id, proposal_id
        ),
    CONSTRAINT chk_contracts_amount CHECK (agreed_amount > 0)
) ENGINE=InnoDB;

CREATE TABLE payments (
    client_user_id INT NOT NULL,
    client_id INT NOT NULL,
    job_id INT NOT NULL,
    freelancer_user_id INT NOT NULL,
    freelancer_id INT NOT NULL,
    proposal_id INT NOT NULL,
    contract_id INT NOT NULL,
    payment_id INT NOT NULL AUTO_INCREMENT,
    amount DECIMAL(10,2) NOT NULL,
    commission DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    PRIMARY KEY (
        client_user_id, client_id, job_id,
        freelancer_user_id, freelancer_id, proposal_id,
        contract_id, payment_id
    ),
    UNIQUE KEY uq_payment_id (payment_id),
    CONSTRAINT fk_payments_contract
        FOREIGN KEY (
            client_user_id, client_id, job_id,
            freelancer_user_id, freelancer_id, proposal_id, contract_id
        )
        REFERENCES contracts (
            client_user_id, client_id, job_id,
            freelancer_user_id, freelancer_id, proposal_id, contract_id
        ),
    CONSTRAINT chk_payments_amount CHECK (amount > 0),
    CONSTRAINT chk_payments_commission CHECK (commission >= 0 AND commission <= amount)
) ENGINE=InnoDB;

CREATE TABLE reviews (
    client_user_id INT NOT NULL,
    client_id INT NOT NULL,
    job_id INT NOT NULL,
    freelancer_user_id INT NOT NULL,
    freelancer_id INT NOT NULL,
    proposal_id INT NOT NULL,
    contract_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    reviewee_id INT NOT NULL,
    review_id INT NOT NULL AUTO_INCREMENT,
    rating INT NOT NULL,
    comment TEXT,
    PRIMARY KEY (
        client_user_id, client_id, job_id,
        freelancer_user_id, freelancer_id, proposal_id,
        contract_id, reviewer_id, reviewee_id, review_id
    ),
    UNIQUE KEY uq_review_id (review_id),
    UNIQUE KEY uq_review_contract_reviewer (
        client_user_id, client_id, job_id,
        freelancer_user_id, freelancer_id, proposal_id,
        contract_id, reviewer_id
    ),
    CONSTRAINT fk_reviews_contract
        FOREIGN KEY (
            client_user_id, client_id, job_id,
            freelancer_user_id, freelancer_id, proposal_id, contract_id
        )
        REFERENCES contracts (
            client_user_id, client_id, job_id,
            freelancer_user_id, freelancer_id, proposal_id, contract_id
        ),
    CONSTRAINT fk_reviews_reviewer
        FOREIGN KEY (reviewer_id) REFERENCES users(id),
    CONSTRAINT fk_reviews_reviewee
        FOREIGN KEY (reviewee_id) REFERENCES users(id),
    CONSTRAINT chk_reviews_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT chk_reviews_different_users CHECK (reviewer_id <> reviewee_id)
) ENGINE=InnoDB;

SHOW TABLES;
