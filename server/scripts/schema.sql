CREATE  TABLE  users (
    user_id INT PRIMARY KEY,
    username VARCHAR(250),
    email VARCHAR (250),
    hash_password VARCHAR(250)
)

CREATE TABLE  organizations(
    org_id INT PRIMARY KEY,
    org_name VARCHAR(250)
)

CREATE TABLE  organization_members(
    org_mem_id INT PRIMARY KEY,
    user_id INT ,
    org_id INT,
    user_role VARCHAR(250)

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (org_id) REFERENCES organizations(org_id)
)
CREATE TABLE  vendor(
    ven_id INT PRIMARY KEY,
    ven_name VARCHAR(250)
)

CREATE TABLE  vendor_members(
    ven_mem_id INT PRIMARY KEY,
    user_id INT ,
    ven_id INT,
    user_role VARCHAR(250)

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (ven_id) REFERENCES vendors(ven_id)
)

CREATE  TABLE  vendor_invite(
    inv_id INT PRIMARY KEY ,
    org_id INT ,
    ven_id INT ,
    inv_url TEXT

    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES organizations(ven_id)
)

CREATE TABLE  vendor_relationship(
     ven_rel_id INT PRIMARY KEY,
     org_id INT ,
     van_id INT,
     rel_status VARCHAR(250),
     compliance_status VARCHAR(250),
    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES organizations(ven_id)
)

CREATE TABLE  requirements(
    req_id INT PRIMARY KEY,
    doc_req VARCHAR(250),
    org_id INT,
    ven_id INT 

    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES organizations(ven_id)
    
)

CREATE TABLE  documents (
    doc_id INT PRIMARY KEY,
    doc_name VARCHAR(250),
    doc_expire_status VARCHAR(250),
    doc metadata VARCHAR(250),
    org_id INT,
    ven_id INT 

    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES organizations(ven_id)

)
CREATE  TABLE  document_versions(
    doc_ver_id INT PRIMARY KEY,
    doc_id INT,
    ven_id INT,
    org_id INT,
    ver_name VARCHAR(250)

    FOREIGN KEY (org_id) REFERENCES organizations(org_id),
    FOREIGN KEY (ven_id) REFERENCES organizations(ven_id),
    FOREIGN KEY (doc_id) REFERENCES documents(doc_id)
)
CREATE TABLE  audit_log(
    audit_id INT 
)
CREATE TABLE  notifications(
    not_id INT
)
CREATE TABLE activity(
    act_id INT,
    act_name VARCHAR(250)
)
