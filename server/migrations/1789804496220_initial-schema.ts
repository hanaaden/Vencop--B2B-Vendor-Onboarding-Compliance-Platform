import type { ColumnDefinitions, MigrationBuilder } from 'node-pg-migrate';


const SchemaUrl = new URL('../scripts/schema.sql' , import.meta.url)

export const shorthands: ColumnDefinitions | undefined = undefined;
import { readFileSync } from 'fs';
const migration = readFileSync(SchemaUrl , {encoding: 'utf8', flag: 'r'})

export async function up(pgm: MigrationBuilder): Promise<void> {
    pgm.sql(migration)
}

export async function down(pgm: MigrationBuilder): Promise<void> {

  pgm.dropTable('refresh_token');
  pgm.dropTable('password_reset');
  pgm.dropTable('verification');
  pgm.dropTable('notifications');
  pgm.dropTable('audit_log');
  pgm.dropTable('document_versions');
  pgm.dropTable('documents');
  pgm.dropTable('requirements');
  pgm.dropTable('vendor_relationship');
  pgm.dropTable('vendor_invite');
  pgm.dropTable('vendor_members');
  pgm.dropTable('vendor');
  pgm.dropTable('organization_members');
  pgm.dropTable('organizations');
  pgm.dropTable('users');
}


