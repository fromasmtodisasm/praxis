
#include "lispCallbacks.h"

#include "PraxisTexture.h"
#include "PraxisServer.h"
#include "PraxisLog.h"

#include "World.h"

#include "SingleWorldConfiguration.h"

extern s7_scheme * g_pLisp;

#include <glm/vec3.hpp> // glm::vec3
#include <glm/vec4.hpp> // glm::vec4
#include <glm/mat4x4.hpp> // glm::mat4
#include <glm/gtc/matrix_transform.hpp> // glm::translate, glm::rotate, glm::scale, glm::perspective

static int s7_type_tag_transform = 0;

static s7_pointer s7cbDrawLine(s7_scheme *sc, s7_pointer args)
{
    float x1 = s7_number_to_real(sc, s7_list_ref(sc, args, 0));
    float y1 = s7_number_to_real(sc, s7_list_ref(sc, args, 1));
    float z1 = s7_number_to_real(sc, s7_list_ref(sc, args, 2));
    float x2 = s7_number_to_real(sc, s7_list_ref(sc, args, 3));
    float y2 = s7_number_to_real(sc, s7_list_ref(sc, args, 4));
    float z2 = s7_number_to_real(sc, s7_list_ref(sc, args, 5));

    glBegin(GL_LINES);

    glVertex3f(x1,y1,z1);
    glVertex3f(x2,y2,z2);

    glEnd();

    return(s7_make_integer(sc, 0));
}

static s7_pointer s7cbNewTransform(s7_scheme * sc, s7_pointer args)
{

    return s7_make_object(sc, s7_type_tag_transform, (void *)0);
}

void lispInitCallbacks()
{
    s7_type_tag_transform = s7_new_type("transform", NULL, NULL, NULL, NULL, NULL, NULL);

    s7_define_function(g_pLisp, "draw-line", s7cbDrawLine, 6, 0, false, "");
}
