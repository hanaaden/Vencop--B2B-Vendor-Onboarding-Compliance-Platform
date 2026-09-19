CREATE  TABLE  users (
    user_id SERIAL PRIMARY KEY ,
    username VARCHAR(250) UNIQUE,
    email VARCHAR(250) NOT NULL UNIQUE,
    first_name VARCHAR(250) NOT NULL,
    last_name VARCHAR(250),
    hash_password VARCHAR(250) NOT NULL,
    email_verified BOOLEAN DEFAULT FALSE,
    account_status VARCHAR(250) DEFAULT 'active' NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL
);

CREATE TABLE  organizations(
    org_id SERIAL PRIMARY KEY  ,
    org_name VARCHAR(250) NOT NULL,
    created_by INT NOT NULL,
    organization_status VARCHAR(250),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,

    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE  organization_members(
    org_mem_id SERIAL PRIMARY KEY ,
    user_id INT NOT NULL ,
    org_id INT NOT NULL,
    UNIQUE (user_id, org_id),
    user_role VARCHAR(250) NOT NULL,
    member_status VARCHAR(250),
    joined_at TIMESTAMP NULL,

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (org_id) REFERENCES organizations(org_id)
);
CREATE TABLE  vendor(
    ven_id SERIAL PRIMARY KEY ,
    ven_name VARCHAR(250) NOT NULL,
    vendor_status VARCHAR(250),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL
);

CREATE TABLE  vendor_members(
    ven_mem_id SERIAL PRIMARY KEY  ,
    user_id INT NOT NULL ,
    ven_id INT NOT NULL,
    user_role VARCHAR(250) NOT NULL,
    member_status VARCHAR(250),
    joined_at TIMESTAMP NULL,
    UNIQUE (user_id, ven_id),

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (ven_id) REFERENCES vendor(ven_id)
);

CREATE  TABLE  vendor_invite(
    inv_id SERIAL PRIMARY KEY ,
    org_id INT NOT NULL,
    ven_id INT NOT NULL,
    inv_url TEXT NOT NULL,
    invited_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expired_at TIMESTAMP NULL,
    accepted_at TIMESTAMP NULL,

    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES vendor(ven_id),

FOREIGN KEY (invited_by) REFERENCES users(user_id)
);

CREATE TABLE  vendor_relationship(
     ven_rel_id SERIAL PRIMARY KEY ,
     org_id INT NOT NULL ,
     ven_id INT NOT NULL ,
     UNIQUE (ven_id, org_id),
     rel_status VARCHAR(250),
     compliance_status VARCHAR(250),
     activated_at TIMESTAMP NULL,
     suspended_at TIMESTAMP NULL,

    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES vendor(ven_id)
);

CREATE TABLE  requirements(
    req_id SERIAL PRIMARY KEY ,
    doc_req VARCHAR(250) NOT NULL,
    org_id INT NOT NULL,
    req_name VARCHAR(250) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,

    FOREIGN KEY (org_id) REFERENCES organizations(org_id)
    
);

CREATE TABLE  documents (
    doc_id SERIAL PRIMARY KEY ,
    req_id INT NOT NULL,
    doc_name VARCHAR(250) NOT NULL,
    doc_metadata VARCHAR(250),
    ven_rel_id INT NOT NULL,

  
    FOREIGN KEY (req_id) REFERENCES requirements(req_id),
    FOREIGN KEY (ven_rel_id) REFERENCES vendor_relationship(ven_rel_id)

);
CREATE  TABLE  document_versions(
    doc_ver_id SERIAL PRIMARY KEY ,
    doc_id INT NOT NULL,
    ver_name VARCHAR(250),
    version_number INT NOT NULL ,
    file_url VARCHAR(250),
    reviewed_at TIMESTAMP NULL,
    uploaded_at TIMESTAMP NULL,
    expires_at TIMESTAMP NULL,
approved_by INT ,
rejected_by INT ,
rejection_reason TEXT,
UNIQUE (doc_id, version_number),

FOREIGN KEY (doc_id) REFERENCES documents(doc_id),
FOREIGN KEY (approved_by) REFERENCES users(user_id),
FOREIGN KEY (rejected_by) REFERENCES users(user_id)
);

CREATE TABLE  audit_log(
    audit_id SERIAL PRIMARY KEY  ,
    user_id INT NOT NULL,
    user_action VARCHAR(250) NOT NULL,
    entity_type VARCHAR(250) NOT NULL,
    entity_id INT,  
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE  notifications(
    not_id SERIAL PRIMARY KEY ,
    title VARCHAR (250) NOT NULL,
    user_id INT NOT NULL,
    messages TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)

);

CREATE TABLE verification(
    ver_id SERIAL PRIMARY KEY ,
    user_id INT NOT NULL,
    ver_token VARCHAR(250) NOT NULL UNIQUE,
    ver_used BOOLEAN DEFAULT FALSE,
    expired_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

     FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE password_reset(
    reset_id SERIAL PRIMARY KEY ,
    user_id INT NOT NULL,
    reset_token VARCHAR(250) NOT NULL UNIQUE,
    reset_used BOOLEAN DEFAULT FALSE,
    expired_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

     FOREIGN KEY (user_id) REFERENCES users(user_id)

);
CREATE TABLE refresh_token(
    refresh_id SERIAL PRIMARY KEY ,
    user_id INT NOT NULL,
    refresh_token VARCHAR(250) NOT NULL UNIQUE,
    is_revoked BOOLEAN DEFAULT FALSE,
    expired_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)

)