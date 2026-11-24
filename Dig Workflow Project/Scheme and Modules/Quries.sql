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
    freelancer_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (freelancer_id, skill_id),
    CONSTRAINT fk_freelancer_skills_freelancer
        FOREIGN KEY (freelancer_id) REFERENCES freelancer(freelancer_id),
    CONSTRAINT fk_freelancer_skills_skill
        FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
) ENGINE=InnoDB;

CREATE TABLE jobs (
    job_id INT NOT NULL AUTO_INCREMENT,
    client_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    budget DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    PRIMARY KEY (client_id, job_id),
    UNIQUE KEY uq_job_id (job_id),
    CONSTRAINT fk_jobs_client
        FOREIGN KEY (client_id) REFERENCES users(id),
    CONSTRAINT chk_jobs_budget CHECK (budget > 0)
) ENGINE=InnoDB;

CREATE TABLE job_skills (
    job_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (job_id, skill_id),
    CONSTRAINT fk_job_skills_job
        FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    CONSTRAINT fk_job_skills_skill
        FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
) ENGINE=InnoDB;

CREATE TABLE proposals (
    proposal_id INT NOT NULL AUTO_INCREMENT,
    job_id INT NOT NULL,
    freelancer_id INT NOT NULL,
    proposed_amount DECIMAL(10,2) NOT NULL,
    cover_letter TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    PRIMARY KEY (job_id, freelancer_id, proposal_id),
    UNIQUE KEY uq_proposal_id (proposal_id),
    UNIQUE KEY uq_proposal_job_freelancer (job_id, freelancer_id),
    CONSTRAINT fk_proposals_job
        FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    CONSTRAINT fk_proposals_freelancer
        FOREIGN KEY (freelancer_id) REFERENCES freelancer(freelancer_id),
    CONSTRAINT chk_proposals_amount CHECK (proposed_amount > 0)
) ENGINE=InnoDB;

CREATE TABLE contracts (
    contract_id INT NOT NULL AUTO_INCREMENT,
    proposal_id INT NOT NULL,
    agreed_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    PRIMARY KEY (proposal_id, contract_id),
    UNIQUE KEY uq_contract_id (contract_id),
    UNIQUE KEY uq_contract_proposal (proposal_id),
    CONSTRAINT fk_contracts_proposal
        FOREIGN KEY (proposal_id) REFERENCES proposals(proposal_id),
    CONSTRAINT chk_contracts_amount CHECK (agreed_amount > 0)
) ENGINE=InnoDB;

CREATE TABLE payments (
    payment_id INT NOT NULL AUTO_INCREMENT,
    contract_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    commission DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    PRIMARY KEY (contract_id, payment_id),
    UNIQUE KEY uq_payment_id (payment_id),
    CONSTRAINT fk_payments_contract
        FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    CONSTRAINT chk_payments_amount CHECK (amount > 0),
    CONSTRAINT chk_payments_commission CHECK (commission >= 0 AND commission <= amount)
) ENGINE=InnoDB;

CREATE TABLE reviews (
    review_id INT NOT NULL AUTO_INCREMENT,
    contract_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    reviewee_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    PRIMARY KEY (contract_id, reviewer_id, reviewee_id, review_id),
    UNIQUE KEY uq_review_id (review_id),
    UNIQUE KEY uq_review_contract_reviewer (contract_id, reviewer_id),
    CONSTRAINT fk_reviews_contract
        FOREIGN KEY (contract_id) REFERENCES contracts(contract_id),
    CONSTRAINT fk_reviews_reviewer
        FOREIGN KEY (reviewer_id) REFERENCES users(id),
    CONSTRAINT fk_reviews_reviewee
        FOREIGN KEY (reviewee_id) REFERENCES users(id),
    CONSTRAINT chk_reviews_rating CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT chk_reviews_different_users CHECK (reviewer_id <> reviewee_id)
) ENGINE=InnoDB;

SHOW TABLES;
