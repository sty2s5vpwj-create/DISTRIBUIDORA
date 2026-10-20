import { describe, expect, it } from 'vitest';
import { sections } from '../src/access';
describe('Navegación por roles combinables (el servidor aplica seguridad)',()=>{
 it('no concede acceso sin rol',()=>expect(sections([])).toEqual([]));
 it('permite combinar vendedor y almacén',()=>expect(sections(['seller','warehouse'])).toEqual(['Mis clientes','Almacenes']));
 it('administración también puede actuar como vendedor',()=>expect(sections(['admin'])).toContain('Mis clientes'));
 it('no muestra administración al vendedor',()=>expect(sections(['seller'])).not.toContain('Administración'));
});
