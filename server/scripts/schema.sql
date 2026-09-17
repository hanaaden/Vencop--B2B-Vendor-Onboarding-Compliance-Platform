CREATE  TABLE  users (
    user_id INT PRIMARY KEY ,
    username VARCHAR(250) UNIQUE,
    email VARCHAR(250) NOT NULL UNIQUE,
    first_name VARCHAR(250) NOT NULL,
    last_name VARCHAR(250),
    hash_password VARCHAR(250),
    email_verified BOOLEAN,
    account_status VARCHAR(250),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL
);

CREATE TABLE  organizations(
    org_id INT PRIMARY KEY ,
    org_name VARCHAR(250) NOT NULL,
    created_by INT,
    organization_status VARCHAR(250),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,

    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE  organization_members(
    org_mem_id INT PRIMARY KEY,
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
    ven_id INT PRIMARY KEY,
    ven_name VARCHAR(250) NOT NULL,
    vendor_status VARCHAR(250),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL
);

CREATE TABLE  vendor_members(
    ven_mem_id INT PRIMARY KEY ,
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
    inv_id INT PRIMARY KEY ,
    org_id INT ,
    ven_id INT ,
    inv_url TEXT,
    invited_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expired_at TIMESTAMP NULL,
    accepted_at TIMESTAMP NULL,

    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES vendor(ven_id),

FOREIGN KEY (invited_by) REFERENCES users(user_id)
);

CREATE TABLE  vendor_relationship(
     ven_rel_id INT PRIMARY KEY,
     org_id INT ,
     ven_id INT,
     rel_status VARCHAR(250),
     compliance_status VARCHAR(250),
     activated_at TIMESTAMP NULL,
     suspended_at TIMESTAMP NULL,

    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES vendor(ven_id)
);

CREATE TABLE  requirements(
    req_id INT PRIMARY KEY,
    doc_req VARCHAR(250) NOT NULL,
    org_id INT,
    req_name VARCHAR(250),
    IS_CREATED BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL,

    FOREIGN KEY (org_id) REFERENCES organizations(org_id)
    
);

CREATE TABLE  documents (
    doc_id INT PRIMARY KEY ,
    req_id INT NOT NULL,
    doc_name VARCHAR(250) NOT NULL,
    doc_expire_status VARCHAR(250),
    doc_metadata VARCHAR(250),
    ven_rel_id INT NOT NULL,
    accepted_at TIMESTAMP NULL,
    rejected_at TIMESTAMP NULL,
    expired_at TIMESTAMP NULL,
    file_url VARCHAR(250),

  
    FOREIGN KEY (req_id) REFERENCES requirements(req_id),
    FOREIGN KEY (ven_rel_id) REFERENCES vendor_relationship(ven_rel_id)

);
CREATE  TABLE  document_versions(
    doc_ver_id INT PRIMARY KEY,
    doc_id INT NOT NULL,
    ver_name VARCHAR(250),
    version_number INT NOT NULL ,
    reviewed_at TIMESTAMP NULL,
    uploaded_at TIMESTAMP NULL,
    expires_at TIMESTAMP NULL,
approved_by INT,
rejected_by INT,
rejection_reason TEXT,
UNIQUE (doc_id, version_number),

FOREIGN KEY (doc_id) REFERENCES documents(doc_id),
FOREIGN KEY (approved_by) REFERENCES users(user_id),
FOREIGN KEY (rejected_by) REFERENCES users(user_id)
);

CREATE TABLE  audit_log(
    audit_id INT PRIMARY KEY ,
    user_id INT,
    act VARCHAR(250),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
CREATE TABLE  notifications(
    not_id INT PRIMARY KEY,
    title VARCHAR (250) NOT NULL,
    user_id INT NOT NULL,
    messages TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(user_id)

);