export type Role = 'admin' | 'seller' | 'warehouse';
export function sections(roles: Role[]) {
  if (roles.includes('admin')) return ['Administración', 'Mis clientes', 'Almacenes', 'Auditoría'];
  return [...(roles.includes('seller') ? ['Mis clientes'] : []), ...(roles.includes('warehouse') ? ['Almacenes'] : [])];
}
