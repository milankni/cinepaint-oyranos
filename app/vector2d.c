/* vector2d
 * Copyright (C) 1998 Jay Cox <jaycox@earthlink.net>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include "vector2d.h"
#include <math.h>

double
vector2d_dot_product (Vector2d *v1, Vector2d *v2)
{
  return ((v1->x * v2->x) + (v1->y * v2->y));
}

double
vector2d_magnitude (Vector2d *v)
{
  return (sqrt((v->x*v->x) + (v->y*v->y)));
}

void
vector2d_set (Vector2d *v, double x, double y)
{
  v->x = x; v->y = y;
}

