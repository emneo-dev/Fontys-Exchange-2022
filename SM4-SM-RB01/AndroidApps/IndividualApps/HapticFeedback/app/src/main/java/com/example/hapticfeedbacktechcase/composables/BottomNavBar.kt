package com.example.hapticfeedbacktechcase.composables

import androidx.compose.foundation.layout.fillMaxHeight
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material.*

import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue

import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.vectorResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

import androidx.navigation.NavController
import androidx.navigation.compose.currentBackStackEntryAsState
import com.example.hapticfeedbacktechcase.R

import com.example.hapticfeedbacktechcase.Screen

@Composable
fun BottomNavBar(navController: NavController, modifier: Modifier = Modifier) {
    val navItems = listOf(
        Screen.HapticResearch,
        Screen.VibrationResearch,
        Screen.CompositionResearch
    )

    val navItemsIcons = listOf(
        ImageVector.vectorResource(id = R.drawable.baseline_vibration_24),
        ImageVector.vectorResource(id = R.drawable.baseline_vibration_24),
        ImageVector.vectorResource(id = R.drawable.baseline_music_note_24)
    )

    BottomAppBar(
        elevation = 10.dp,
        backgroundColor = MaterialTheme.colors.secondary,
        cutoutShape = RectangleShape,
        modifier = modifier
    ) {
        val navBackStackEntry by navController.currentBackStackEntryAsState()
        val currentRoute = navBackStackEntry?.destination?.route

        navItems.forEachIndexed { index, item ->
            BottomNavigationItem(
                icon = { Icon(navItemsIcons[index], contentDescription = item.screenName) },
                label = { Text(text = item.screenName, fontSize = 9.sp) },
                alwaysShowLabel = false,
                selected = currentRoute == item.route,
                onClick = {
                    navController.navigate(item.route) {
                        navController.graph.startDestinationRoute?.let {route ->
                            popUpTo(route) {
                                saveState = true
                            }
                        }
                        launchSingleTop = true
                        restoreState = true
                    }
                }
            )
            if (index < navItems.size - 1) {
                Divider(modifier = Modifier.padding(2.dp).fillMaxHeight().width(1.dp))
            }
        }
    }
}
